import 'package:flutter/material.dart';
import 'dart:math';

class SplashIcon extends StatelessWidget {
  const SplashIcon({
    Key key,
    @required AnimationController animationController,
    this.top,
    this.left,
    this.right,
    this.bottom,
    @required this.angle,
    @required this.icon,
    @required this.color,
    @required this.size,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final double top, left, right, bottom, angle, size;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: RotationTransition(
        turns: _animationController,
        alignment: Alignment.center,
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Icon(
            icon,
            color: color,
            size: size,
          ),
        ),
      ),
    );
  }
}
