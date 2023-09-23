import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';

void main() {
  group('Coordinates', () {
    test('Two instances with the same values should be equal', () {
      const coordinates1 = Coordinates(lat: 40.712, lon: -74.006);
      const coordinates2 = Coordinates(lat: 40.712, lon: -74.006);

      expect(coordinates1, equals(coordinates2));
    });

    test('Empty coordinates should have lat and lon set to 0', () {
      const emptyCoordinates = Coordinates.empty();

      expect(emptyCoordinates.lat, equals(0));
      expect(emptyCoordinates.lon, equals(0));
    });

    test('hashCode should be consistent with equality', () {
      const coordinates1 = Coordinates(lat: 40.712, lon: -74.006);
      const coordinates2 = Coordinates(lat: 40.712, lon: -74.006);

      expect(coordinates1.hashCode, equals(coordinates2.hashCode));
    });

    test('toString should return a formatted string', () {
      const coordinates = Coordinates(lat: 40.712, lon: -74.006);
      const expectedString = 'Coordinates(lat: 40.712, lon: -74.006)';

      // Compare the strings, ignoring leading/trailing whitespaces
      expect(coordinates.toString(), equals(expectedString));
    });
  });
}
