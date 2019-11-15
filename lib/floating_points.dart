import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: FloatingNumbersDemo(),
    ),
  );
}

class FloatingNumbersDemo extends StatefulWidget {
  @override
  FloatingNumbersDemoState createState() => FloatingNumbersDemoState();
}

class FloatingNumbersDemoState extends State<FloatingNumbersDemo> {
  List<Widget> numbers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _onTapDown),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 200,
          child: Stack(
            children: <Widget>[
              ...numbers,
            ],
          ),
        ),
      ),
    );
  }

  Future _onTapDown() async {
    for (var i = 1; i < 11; ++i) {
      setState(() {
        var selector = (i - 1) % 10;
        numbers.add(FloatingNumber(
          number: i,
          color: colors[selector],
          direction: directions[selector],
        ));
      });
      await Future.delayed(Duration(milliseconds: 100));
    }
  }
}

enum Direction { start, end }

class FloatingNumber extends StatefulWidget {
  final int number;
  final Color color;
  final Direction direction;

  const FloatingNumber({
    Key key,
    @required this.number,
    @required this.color,
    this.direction = Direction.start,
  }) : super(key: key);

  @override
  FloatingNumberState createState() => FloatingNumberState();
}

class FloatingNumberState extends State<FloatingNumber>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  final _animationDuration = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    final dx = widget.direction == Direction.start ? -0.5 : 0.5;

    _slideAnimation =
        Tween<Offset>(begin: Offset(dx, 7.0), end: Offset(dx, -10.0))
            .animate(_controller);

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .chain(CurveTween(curve: Curves.easeInOutSine))
        .animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return AnimatedOpacity(
          opacity: _opacityAnimation.value,
          duration: _animationDuration,
          child: SlideTransition(
            position: _slideAnimation,
            child: Text(
              '+${widget.number}',
              style: TextStyle(
                color: widget.color,
                fontSize: 18.0 + widget.number,
              ),
            ),
          ),
        );
      },
    );
  }
}

const List<Direction> directions = [
  Direction.start,
  Direction.start,
  Direction.start,
  Direction.end,
  Direction.end,
  Direction.end,
  Direction.start,
  Direction.start,
  Direction.end,
  Direction.end,
];

const List<Color> colors = [
  Color(0xFF3AEAFF),
  Color(0xFF3CCD48),
  Color(0xFFFFFC21),
  Color(0xFFF1A26C),
  Color(0xFFED49AA),
  Color(0xFF10F0FF),
  Color(0xFF02F019),
  Color(0xFFFDF525),
  Color(0xFFFF8C02),
  Color(0xFFFF58D6),
];
