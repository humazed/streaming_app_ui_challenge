import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaming_app_ui_challange/pages/home.dart';
import 'package:streaming_app_ui_challange/pages/points_provider.dart';
import 'package:streaming_app_ui_challange/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Streaming app ui challange',
      theme: appTheme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (_) => PointsProvider()),
        ],
        child: HomePage(),
      ),
    );
  }
}
