import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedButton({Key key, this.onPressed}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: 1.4),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 0.6),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.6, end: 1.0),
          weight: 1,
        ),
      ],
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return ScaleTransition(
          scale: animation,
          child: FloatingActionButton(
            onPressed: _onTapDown,
            child: Icon(
              Icons.star,
              color: Colors.white,
            ),
            mini: true,
          ),
        );
      },
    );
  }

  Future _onTapDown() async {
    widget.onPressed();

    await _controller.forward();
    _controller.reset();
  }
}

// for testing
class BounceDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AnimatedButton()),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: BounceDemo(),
    ),
  );
}
