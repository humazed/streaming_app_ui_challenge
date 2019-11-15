import 'package:flutter/material.dart';
import 'package:streaming_app_ui_challange/HomePage.dart';
import 'package:streaming_app_ui_challange/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streaming app ui challange',
      theme: appTheme,
      home: HomePage(),
    );
  }
}
