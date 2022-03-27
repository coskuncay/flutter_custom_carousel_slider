part of flutter_custom_carousel_slider;

class CarouselItem {
  /// Title of item [String]
  String? title;

  /// [TextStyle] of Title
  TextStyle? titleTextStyle;

  /// Title of leftSubtitle [String]
  String? leftSubtitle;

  /// [TextStyle] of leftSubtitle
  TextStyle? leftSubtitleTextStyle;

  /// Title of rightSubtitle [String]
  String? rightSubtitle;

  /// [TextStyle] of rightSubtitle
  TextStyle? rightSubtitleTextStyle;

  /// [Function] of on image tap event with current page index
  void Function(int)? onImageTap;

  /// [BoxDecoration] of item
  BoxDecoration? boxDecoration;

  /// image of item
  // ignore: prefer_typing_uninitialized_variables
  var image;

  CarouselItem({
    this.title,
    this.titleTextStyle,
    this.leftSubtitle,
    this.leftSubtitleTextStyle,
    this.rightSubtitle,
    this.rightSubtitleTextStyle,
    this.onImageTap,
    this.boxDecoration,
    this.image,
  });
}
