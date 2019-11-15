import 'package:flutter/material.dart';
import 'package:streaming_app_ui_challange/button_bounce.dart';
import 'package:streaming_app_ui_challange/floating_points.dart';
import 'package:streaming_app_ui_challange/puls.dart';

void main() {
  runApp(
    MaterialApp(
      home: StarButtonDemo(),
    ),
  );
}

class StarButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: StarButton(),
      ),
    );
  }
}

class StarButton extends StatefulWidget {
  @override
  StarButtonState createState() => StarButtonState();
}

class StarButtonState extends State<StarButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  var pulseAnimationDuration = const Duration(milliseconds: 300);

  Animation<double> pulseAnimation;

  List<Widget> numbers = [];

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
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width / 2,
      height: size.width ,
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
            bottom: 46,
            end: 24,
            child: SizedBox(
              height: 300,
              width: 48,
              child: Stack(
                children: numbers,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -28,
            end: -48,
            child: CustomPaint(
              painter: PulsePainter(pulseAnimation),
              child: SizedBox(
                width: size.width / 2,
                height: size.width / 2,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 46,
            end: 24,
            child: AnimatedButton(
              onPressed: () {
                _startPulseAnimation();
                Stream.periodic(pulseAnimationDuration, (v) => v)
                    .take(5)
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
