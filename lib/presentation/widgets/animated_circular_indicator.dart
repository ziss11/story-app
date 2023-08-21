import 'dart:math';

import 'package:flutter/material.dart';
import 'package:story_app/utils/animations/loader_animation.dart';

class AnimatedCircularIndicator extends StatefulWidget {
  final Color? color;

  const AnimatedCircularIndicator({super.key, this.color});

  @override
  State<AnimatedCircularIndicator> createState() =>
      _AnimatedCircularIndicatorState();
}

class _AnimatedCircularIndicatorState extends State<AnimatedCircularIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = Tween(begin: 1.0, end: 1.4).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));
    controller.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.status == AnimationStatus.forward
                ? (pi * 2) * controller.value
                : -(pi * 2) * controller.value,
            child: CustomPaint(
              foregroundPainter: LoaderAnimation(
                radiusRatio: controller.value,
                color: widget.color,
              ),
              size: const Size(70, 70),
            ),
          );
        },
      ),
    );
  }
}
