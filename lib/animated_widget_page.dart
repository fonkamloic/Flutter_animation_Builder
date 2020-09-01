import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatioWidgetPage extends StatefulWidget {
  @override
  _AnimatioWidgetPageState createState() => _AnimatioWidgetPageState();
}

class _AnimatioWidgetPageState extends State<AnimatioWidgetPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    final curvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOut);
    animation =
        Tween<double>(begin: 0, end: 2 * math.pi).animate(curvedAnimation)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RotatingTransition(animation: animation, child: MyImage()));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class RotatingTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const RotatingTransition(
      {Key key, @required this.animation, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: child,
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(angle: animation.value, child: child);
      },
    );
  }
}

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('images/img.png'),
      alignment: Alignment.center,
      padding: EdgeInsets.all(30),
    );
  }
}
