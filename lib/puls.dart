import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: SpriteDemo(),
    ),
  );
}

class PulsePainter extends CustomPainter {
  final Animation<double> _animation;

  PulsePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    print("value = ${value}");
    double opacity = (1.0 - (value / 2.0)).clamp(0.0, 1.0);
    print("opacity = ${opacity}");
//    Color color = Colors.yellow.withOpacity(opacity == 0.5 ? 0.0 : opacity);
    Color color = Colors.yellow.withOpacity(opacity);

    double size = rect.width / 4;
    double radius = size * value;

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);

    for (int wave = 1; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(PulsePainter oldDelegate) {
    return false;
  }
}

class SpriteDemo extends StatefulWidget {
  @override
  SpriteDemoState createState() => SpriteDemoState();
}

class SpriteDemoState extends State<SpriteDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  var animationDuration = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    _controller.stop();
    _controller.reset();

    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Pulse')),
      body: Center(
        child: CustomPaint(
          painter: PulsePainter(_controller),
          child: SizedBox(
            width: size.width / 2,
            height: size.width / 2,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Stream.periodic(animationDuration, (v) => v)
              .take(10)
              .listen((count) => _startAnimation());
          },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
