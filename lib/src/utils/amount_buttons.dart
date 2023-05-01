import 'package:custom_carousel/src/style/carousel_sizes.dart';

int amountOfButtons(double width) {
  return (width - CarouselSizes.buttonTransition) ~/ CarouselSizes.itemSubtitle;
}
