import 'package:custom_carousel/src/style/carousel_padding.dart';
import 'package:custom_carousel/src/style/carousel_sizes.dart';
import 'package:custom_carousel/src/utils/amount_buttons.dart';
import 'package:flutter/material.dart';

class SubtitleComponent extends StatelessWidget {
  final Widget? left;
  final List<Widget> list;
  final Widget? right;
  final double width;
  final int count;

  const SubtitleComponent({
    super.key,
    this.left,
    required this.list,
    this.right,
    required this.width,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    int amount = amountOfButtons(width);
    double newWidth = countNewWidth(amount);
    const int numberButtons = 2;
    return Padding(
      padding: CarouselPadding.paddingSubtitle,
      child: Row(
        children: [
          left ?? Container(),
          SizedBox(
            width: right != null
                ? width - CarouselSizes.buttonTransition * numberButtons
                : width,
            child: content(newWidth, amount),
          ),
          right ?? Container()
        ],
      ),
    );
  }

  Widget content(double newWidth, int amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: newWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: list,
          ),
        ),
        Visibility(visible: amount < count, child: const Text('...'))
      ],
    );
  }

  double countNewWidth(int amount) {
    double newWidth = right != null ? width - 80 : width;
    return amount < count ? newWidth - 15 : newWidth;
  }
}
