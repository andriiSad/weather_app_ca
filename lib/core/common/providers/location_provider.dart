import 'package:flutter/foundation.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';

class LocationProvider extends ChangeNotifier {
  Coordinates? _coordinates;

  Coordinates? get coordinates => _coordinates;

  set coordinates(Coordinates? coordinates) {
    if (_coordinates != coordinates) _coordinates = coordinates;
    notifyListeners();
  }

  void initLocation(Coordinates? coordinates) {
    if (_coordinates != coordinates) _coordinates = coordinates;
  }
}
