import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PointsProvider with ChangeNotifier {
  static PointsProvider of(BuildContext context) =>
      Provider.of<PointsProvider>(context);

  static int _myInitialPoints = 900;

  int get myInitialPoints => _myInitialPoints;

  static int _myPoints = _myInitialPoints;

  int get myPoints => _myPoints;

  static int _postInitialPoints = 30;

  int get postInitialPoints => _postInitialPoints;

  int _postPoints = _postInitialPoints;

  int get postPoints => _postPoints;

  // Allowing negative number to myPoints as it kinda acceptable in real life.
  givePoints(int points) async {
    for (var i = 0; i < points; ++i) {
      _myPoints -= 1;
      _postPoints = _postInitialPoints + _myInitialPoints - _myPoints;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
    }
  }
}
