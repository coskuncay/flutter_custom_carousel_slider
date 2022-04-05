part of flutter_custom_carousel_slider;

enum IndicatorPosition { insidePicture, bottom, none }

extension IndicatorExtension on IndicatorPosition {
  bool get showIndicator {
    switch (this) {
      case IndicatorPosition.insidePicture:
        return true;
      case IndicatorPosition.bottom:
        return true;
      case IndicatorPosition.none:
        return false;
      default:
        return true;
    }
  }

  bool get showIndicatorInside {
    switch (this) {
      case IndicatorPosition.insidePicture:
        return true;
      default:
        return false;
    }
  }

  bool get showIndicatorBottom {
    switch (this) {
      case IndicatorPosition.bottom:
        return true;
      default:
        return false;
    }
  }
}
