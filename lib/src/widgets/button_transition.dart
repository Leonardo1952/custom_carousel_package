import 'package:custom_carousel/src/style/carousel_sizes.dart';
import 'package:flutter/material.dart';

class ButtonTransition extends StatefulWidget {
  final Widget content;
  final bool left;

  const ButtonTransition({
    super.key,
    required this.left,
    required this.content,
  });

  @override
  State<ButtonTransition> createState() => _ButtonTransitionState();
}

class _ButtonTransitionState extends State<ButtonTransition> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.left ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: CarouselSizes.buttonTransition,
        child: widget.content,
      ),
    );
  }
}
