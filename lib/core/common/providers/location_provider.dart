import 'package:flutter/foundation.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/core/utils/constants.dart';

class LocationProvider extends ChangeNotifier {
  Coordinates _coordinates = kDefaultCoordinates;

  Coordinates get coordinates => _coordinates;

  set coordinates(Coordinates coordinates) {
    if (_coordinates != coordinates) _coordinates = coordinates;
    Future.delayed(Duration.zero, notifyListeners);
  }

  void initLocation(Coordinates coordinates) {
    if (_coordinates != coordinates) _coordinates = coordinates;
  }
}
