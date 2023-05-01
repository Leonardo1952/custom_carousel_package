import 'dart:async';
import 'package:custom_carousel/src/components/subtitle_component.dart';
import 'package:custom_carousel/src/models/manualTransition.dart';
import 'package:custom_carousel/src/style/carousel_decoration.dart';
import 'package:custom_carousel/src/style/carousel_sizes.dart';
import 'package:custom_carousel/src/style/carousel_style.dart';
import 'package:custom_carousel/src/utils/amount_buttons.dart';
import 'package:custom_carousel/src/utils/converter_num_alp.dart';
import 'package:custom_carousel/src/utils/determine_page.dart';
import 'package:custom_carousel/src/widgets/button_transition.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  ///List of items you want to show in the carousel
  final List<Widget> items;

  ///Speed at which items will automatically change
  final Duration autoTransitionTime;

  ///Transition speed between items in manual way
  final Duration animationTransition;

  ///Transition between items automatically. The default value is true.
  final bool transitionAutomatic;

  ///Carousel window height.
  final double height;

  ///Carousel window width.
  final double width;

  ///type Transition will receive the type of ManualTransition control you want to use.
  ///Example: ManualTransition.line
  final String typeTransition;
  const CustomCarousel({
    super.key,
    required this.items,
    this.autoTransitionTime = const Duration(seconds: 3),
    this.transitionAutomatic = true,
    this.height = CarouselSizes.defaultSize,
    this.width = CarouselSizes.defaultSize,
    this.typeTransition = ManualTransition.none,
    this.animationTransition = const Duration(milliseconds: 250),
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  int newIndex = 0;
  int delta = 0;
  int itemCount = 0;
  late int amount;
  List<Widget> contentList = [];
  int countItens = 0;

  @override
  void initState() {
    amount = amountOfButtons(widget.width);
    countItens = amount < widget.items.length ? amount : widget.items.length;
    if (widget.transitionAutomatic) {
      playTransition(widget.autoTransitionTime, 1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: positionItens(),
        ),
        subtitle(),
      ],
    );
  }

  Stack positionItens() {
    return Stack(
      alignment: Alignment.center,
      children: [
        gesture(),
        Visibility(
          visible: widget.typeTransition == ManualTransition.arrow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonTransition(
                left: true,
                content: iconAction(
                  Icons.arrow_back_ios,
                  -1,
                  widget.animationTransition,
                ),
              ),
              ButtonTransition(
                left: false,
                content: iconAction(
                  Icons.arrow_forward_ios,
                  1,
                  widget.animationTransition,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget gesture() {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        delta = details.primaryVelocity!.sign.toInt();
        itemCount = widget.items.length;
        newIndex = determinePage(itemCount, currentIndex, delta);
        widget.typeTransition == ManualTransition.gesture
            ? function(newIndex)
            : {};
      },
      child: content(),
    );
  }

  PageView content() {
    return PageView(
      controller: pageController,
      children: widget.items,
      onPageChanged: (int index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }

  IconButton iconAction(IconData icon, int delta, Duration duration) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        newIndex = determinePage(widget.items.length, currentIndex, delta);
        function(newIndex);
      },
    );
  }

  void playTransition(Duration duration, int delta) {
    Timer.periodic(widget.autoTransitionTime, (timer) {
      newIndex = determinePage(widget.items.length, currentIndex, delta);
      function(newIndex);
    });
  }

  Widget subtitle() {
    return SizedBox(width: widget.width, child: hasTypeTransition());
  }

  Widget hasTypeTransition() {
    switch (widget.typeTransition) {
      case ManualTransition.numeric:
        return SubtitleComponent(
          count: widget.items.length,
          width: widget.width,
          left: ButtonTransition(
              left: true,
              content: iconAction(Icons.keyboard_double_arrow_left, -1,
                  widget.animationTransition)),
          list: numericalButtons(),
          right: ButtonTransition(
              left: false,
              content: iconAction(Icons.keyboard_double_arrow_right, 1,
                  widget.animationTransition)),
        );
      case ManualTransition.ball:
        return SubtitleComponent(
          list: ballButtons(),
          width: widget.width,
          count: widget.items.length,
        );
      case ManualTransition.line:
        return SubtitleComponent(
          list: lineButtons(),
          width: widget.width,
          count: widget.items.length,
        );
      case ManualTransition.alfabetic:
        return SubtitleComponent(
          list: alphabeticButtons(),
          width: widget.width,
          count: widget.items.length,
        );
      default:
        return Container();
    }
  }

  List<Widget> numericalButtons() {
    contentList = [];
    for (int i = 0; i < countItens; i++) {
      contentList.add(
        InkWell(
          child: Text(
            (i + 1).toString(),
            style: CarousselStyle.subtitle,
          ),
          onTap: () {
            function(i);
          },
        ),
      );
    }
    return contentList;
  }

  List<Widget> ballButtons() {
    contentList = [];
    for (int i = 0; i < countItens; i++) {
      contentList.add(InkWell(
        child: Container(
          width: CarouselSizes.itemSubtitle,
          height: CarouselSizes.itemSubtitle,
          decoration: CarouselDecoration.subtitleButtons,
        ),
        onTap: () {
          function(i);
        },
      ));
    }
    return contentList;
  }

  List<Widget> lineButtons() {
    contentList = [];
    for (int i = 0; i < countItens; i++) {
      contentList.add(InkWell(
        child: Container(
          width: CarouselSizes.itemSubtitle,
          height: CarouselSizes.lineHeight,
          decoration: CarouselDecoration.subtitleButtons,
        ),
        onTap: () {
          function(i);
        },
      ));
    }
    return contentList;
  }

  List<Widget> alphabeticButtons() {
    contentList = [];
    for (int i = 0; i < countItens; i++) {
      contentList.add(InkWell(
        child: Text(
          converterNumAlp(i + 1),
          style: CarousselStyle.subtitle,
        ),
        onTap: () {
          function(i);
        },
      ));
    }
    return contentList;
  }

  Future function(int index) {
    return pageController.animateToPage(
      index,
      duration: widget.animationTransition,
      curve: Curves.linear,
    );
  }
}
