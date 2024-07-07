import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/background_image.dart';

class Background extends StatelessWidget {
  final Widget child;
  final int totalPage;
  final List<BackgroundItem> backgroundItems; // Updated to use BackgroundItem
  final double speed;
  final double verticalOffset;
  final double horizontalOffset;
  final bool centerBackground;

  Background({
    required this.verticalOffset,
    required this.child,
    required this.centerBackground,
    required this.totalPage,
    required this.backgroundItems,
    required this.speed,
    required this.horizontalOffset,
  });

  @override
  Widget build(BuildContext context) {
    assert(backgroundItems.length == totalPage);
    return Stack(
      children: [
        for (int i = 0; i < totalPage; i++)
          BackgroundImage(
              centerBackground: centerBackground,
              horizontalOffset: horizontalOffset,
              verticalOffset: verticalOffset,
              id: totalPage - i,
              speed: speed,
              backgroundItem: backgroundItems[totalPage - i - 1]),
        child,
      ],
    );
  }
}
