library flutter_custom_carousel_slider;

import 'package:flutter/material.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    Key? key,
    required List<String> this.children,
    this.height = 200,
  }) : super(key: key);

  /// element list
  final List<String>? children;

  /// height of container
  final double height;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: 200,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
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
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          // color: sourceList[index].color.withOpacity(.2),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "http://via.placeholder.com/350x150",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    controller: _pageController,
                    itemCount: widget.children!.length,
                    onPageChanged: (value) {
                      setState(() {
                        selectedindex = value;
                      });
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    height: widget.height * .45,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter,
                          colors: [
                            Colors.black.withOpacity(1),
                            Colors.black.withOpacity(.1),
                          ],
                          stops: const [0.0, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Flexible(
                            child: Text(
                              'Büyükşehir Belediyesi Olağan Toplantısı Gerçekleşti',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Flexible(
                                  child: Text(
                                    '21.02.2022',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: _buildPageIndicator(),
                                ),
                                const Flexible(
                                  child: Text(
                                    '14:02',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  int selectedindex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  Duration pageTurnDuration = const Duration(milliseconds: 500);

  Curve pageTurnCurve = Curves.ease;

  void _goForward() {
    if (_pageController.page == 5.0) {
      _pageController.animateToPage(0,
          duration: pageTurnDuration, curve: pageTurnCurve);
    } else {
      _pageController.nextPage(
          duration: pageTurnDuration, curve: pageTurnCurve);
    }
  }

  void _goBack() {
    if (_pageController.page == 0.0) {
      _pageController.animateToPage(5,
          duration: pageTurnDuration, curve: pageTurnCurve);
    } else {
      _pageController.previousPage(
          duration: pageTurnDuration, curve: pageTurnCurve);
    }
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.children!.length; i++) {
      list.add(i == selectedindex ? _indicator(true) : _indicator(false));
    }
    return Row(
      children: list,
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: const Color(0XFF2FB7B2).withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? const Color(0XFF6BC4C9) : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
