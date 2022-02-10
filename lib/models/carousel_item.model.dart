part of flutter_custom_carousel_slider;

class CarouselItem {
  /// Title of item
  String? title;

  /// [TextStyle] of Title
  TextStyle? titleTextStyle;

  /// Title of leftSubtitle
  String? leftSubtitle;

  /// [TextStyle] of leftSubtitle
  TextStyle? leftSubtitleTextStyle;

  /// Title of rightSubtitle
  String? rightSubtitle;

  /// [TextStyle] of rightSubtitle
  TextStyle? rightSubtitleTextStyle;

  /// [Function] of on image tap event
  void Function()? onImageTap;

  /// [BoxDecoration] of item
  BoxDecoration? boxDecoration;

  /// [NetworkImage] of item
  final NetworkImage image;

  CarouselItem({
    this.title,
    this.titleTextStyle,
    this.leftSubtitle,
    this.leftSubtitleTextStyle,
    this.rightSubtitle,
    this.rightSubtitleTextStyle,
    this.onImageTap,
    this.boxDecoration,
    required this.image,
  });
}
