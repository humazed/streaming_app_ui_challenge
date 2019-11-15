import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fade Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Blink(
              duration: const Duration(milliseconds: 1000),
              child: Text(
                'Fader',
                style: TextStyle(fontSize: 32.0),
              ))),
    );
  }
}

class Blink extends StatefulWidget {
  Blink({this.child, this.duration});

  final Widget child;
  final Duration duration;

  @override
  createState() => BlinkState();
}

class BlinkState extends State<Blink> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween(begin: 1.0, end: 0.0).animate(curve);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        controller.reverse();
      else if (status == AnimationStatus.dismissed) controller.forward();
    });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FadeTransition(
          opacity: animation,
          child: widget.child,
        ),
      ),
    );
  }
}
