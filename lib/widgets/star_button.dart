import 'package:flutter/material.dart';
import 'package:streaming_app_ui_challange/widgets/button_bounce.dart';
import 'package:streaming_app_ui_challange/widgets/floating_points.dart';
import 'package:streaming_app_ui_challange/widgets/pulse.dart';

class StarButton extends StatefulWidget {
  final VoidCallback onPressed;

  const StarButton({Key key, this.onPressed}) : super(key: key);

  @override
  StarButtonState createState() => StarButtonState();
}

class StarButtonState extends State<StarButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  var pulseAnimationDuration = const Duration(milliseconds: 300);

  Animation<double> pulseAnimation;

  List<FloatingNumber> numbers = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: pulseAnimationDuration,
    );

    pulseAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -1.0, end: -0.0),
          weight: 0.01,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.0, end: -1.0),
          weight: 0.01,
        ),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _startPulseAnimation() async {
    _controller.stop();
    _controller.reset();

    await _controller.forward();
  }

  Future _showNumbers() async {
    for (var i = 1; i < 11; ++i) {
      setState(() {
        // subtract 1 because the loop starts from 0, and take mod 10 to limit it to the array bounds.
        var selector = (i - 1) % 10;
        numbers.add(FloatingNumber(
          number: i,
          color: colors[selector],
          direction: directions[selector],
        ));
      });
      await Future.delayed(Duration(milliseconds: 300));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: 44,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          PositionedDirectional(
            bottom: 0,
            end: -2,
            child: SizedBox(
              height: 100,
              width: 48,
              child: Stack(
                children: numbers,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -128,
            end: -128,
            child: CustomPaint(
              painter: PulsePainter(pulseAnimation),
              child: SizedBox(
                width: 300,
                height: 300,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -2,
            end: -2,
            child: AnimatedButton(
              onPressed: () {
                widget.onPressed?.call();

                _startPulseAnimation();
                Stream.periodic(pulseAnimationDuration, (v) => v)
                    .take(10)
                    .listen((count) => _startPulseAnimation());
                _showNumbers();
              },
            ),
          ),
        ],
      ),
    );
  }
}

// for testing
class StarButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StarButton(),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: StarButtonDemo(),
    ),
  );
}
