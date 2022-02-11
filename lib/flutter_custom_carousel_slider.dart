library flutter_custom_carousel_slider;

import 'dart:async';
import 'package:flutter/material.dart';

//Models
part 'models/carousel_item.model.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    Key? key,
    required this.items,
    this.height = 200,
    this.subHeight,
    this.width = 400,
    this.autoplay = true,
    this.animationCurve = Curves.ease,
    this.autoplayDuration = const Duration(seconds: 3),
    this.animationDuration = const Duration(milliseconds: 300),
    this.indicatorShape = BoxShape.circle,
    this.dotSpacing = 5.0,
    this.selectedDotColor = Colors.white,
    this.selectedDotHeight = 8,
    this.selectedDotWidth = 8,
    this.unselectedDotColor = const Color(0XFFACAEBA),
    this.unselectedDotHeight = 6,
    this.unselectedDotWidth = 6,
    this.showIndicator = true,
    this.showSubBackground = true,
    this.showText = true,
    this.boxPaddingHorizontal = 10,
    this.boxPaddingVertical = 2,
  }) : super(key: key);

  /// [List<CarouselItem>] item list
  final List<CarouselItem> items;

  /// Height of container.Default is 200
  final double height;

  /// Height of sub container.Default is height * .4
  final double? subHeight;

  /// Width of container. Default is 400
  final double width;

  /// Show of indicators. Default true
  final bool showIndicator;

  /// Show title background(Box). Default true
  final bool showSubBackground;

  /// Show all text. Default true
  final bool showText;

  /// Auto play of the slider. Default true
  final bool autoplay;

  /// Transition page animation timing [Curve]. Default is [Curves.ease]
  final Curve animationCurve;

  /// [Duration] page animation duration. Default is 300ms.
  final Duration animationDuration;

  /// [Duration] of the Auto play slider. Default 3 seconds
  final Duration autoplayDuration;

  /// Shape of indicator. Default is [BoxShape.circle]
  final BoxShape indicatorShape;

  /// Horizontal margin between of each dot. Default is 5.0
  final double dotSpacing;

  /// [Color] of selected dot. Default is Color(0XFFACAEBA)
  final Color selectedDotColor;

  /// Height of selected dot. Default is 8
  final double selectedDotHeight;

  /// Width of selected dot. Default is 8
  final double selectedDotWidth;

  /// [Color] of unselected dot. Default is Color(0XFFACAEBA)
  final Color unselectedDotColor;

  /// Height of selected dot. Default is 6
  final double unselectedDotHeight;

  /// Width of selected dot. Default is 6
  final double unselectedDotWidth;

  /// [double] Box Padding Horizontal. Default is 10.0
  final double boxPaddingHorizontal;

  /// [double] Box Padding Vertical. Default is 2.0
  final double boxPaddingVertical;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  Timer? timer;
  late PageController _pageController;
  int selectedIndex = 0;

  TextStyle subtitleTextstyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  TextStyle titleTextstyle = const TextStyle(
    color: Colors.white,
    fontSize: 13,
  );

  BoxDecoration boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: FractionalOffset.bottomCenter,
      end: FractionalOffset.topCenter,
      colors: [
        Colors.black.withOpacity(1),
        Colors.black.withOpacity(.3),
      ],
      stops: const [0.0, 1.0],
    ),
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    if (widget.autoplay) {
      timer = Timer.periodic(widget.autoplayDuration, (_) {
        if (_pageController.hasClients) {
          _goForward();
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.items[selectedIndex].onImageTap != null) {
                  widget.items[selectedIndex].onImageTap!(selectedIndex);
                }
              },
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  _goForward();
                } else if (details.primaryVelocity! > 0) {
                  _goBack();
                }
              },
              child: Stack(
                children: [
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext ctx, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: widget.items[selectedIndex].image,
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    },
                    controller: _pageController,
                    itemCount: widget.items.length,
                    onPageChanged: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                  widget.showSubBackground
                      ? Positioned(
                          bottom: 0,
                          height: widget.subHeight ?? widget.height * .4,
                          width: widget.width,
                          child: Container(
                            decoration:
                                widget.items[selectedIndex].boxDecoration ??
                                    boxDecoration,
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.boxPaddingHorizontal,
                              vertical: widget.boxPaddingVertical,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.items[selectedIndex].title ?? '',
                                    style: widget.items[selectedIndex]
                                            .titleTextStyle ??
                                        titleTextstyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  widget.showIndicator
                      ? Positioned.fill(
                          bottom: 5,
                          child: Align(
                            child: _buildIndicator(),
                            alignment: Alignment.bottomRight,
                          ),
                        )
                      : Container(),
                  widget.showText
                      ? Positioned(
                          bottom: 5,
                          left: 10,
                          child: Text(
                            widget.items[selectedIndex].leftSubtitle ?? '',
                            style: widget.items[selectedIndex]
                                    .leftSubtitleTextStyle ??
                                subtitleTextstyle,
                          ),
                        )
                      : Container(),
                  widget.showText
                      ? Positioned(
                          bottom: 5,
                          right: 10,
                          child: Text(
                            widget.items[selectedIndex].rightSubtitle ?? '',
                            style: widget.items[selectedIndex]
                                    .rightSubtitleTextStyle ??
                                subtitleTextstyle,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goForward() {
    if (_pageController.page == widget.items.length - 1) {
      _pageController.animateToPage(0,
          duration: widget.animationDuration, curve: widget.animationCurve);
    } else {
      _pageController.nextPage(
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  void _goBack() {
    if (_pageController.page == 0.0) {
      _pageController.animateToPage(widget.items.length - 1,
          duration: widget.animationDuration, curve: widget.animationCurve);
    } else {
      _pageController.previousPage(
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  Widget _buildIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.items.length; i++) {
      list.add(i == selectedIndex ? _indicator(true, i) : _indicator(false, i));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: list,
    );
  }

  Widget _indicator(bool isActive, int ind) {
    return InkWell(
      onTap: () {
        _pageController.animateToPage(ind,
            duration: widget.animationDuration, curve: widget.animationCurve);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: widget.dotSpacing),
        height: isActive ? 8 : 6.0,
        width: isActive ? 8 : 6.0,
        decoration: BoxDecoration(
          shape: widget.indicatorShape,
          color: isActive ? widget.selectedDotColor : widget.unselectedDotColor,
        ),
      ),
    );
  }
}
