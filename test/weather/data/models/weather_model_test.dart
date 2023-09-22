import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/data/models/weather_model.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tModel = const WeatherModel.empty().copyWith(
    date: DateFormat('d MMMM y').format(DateTime.now()),
  );

  final tJson = fixture('weather.json');

  //TODO(refactor this cast)
  final tMap = (jsonDecode(tJson) as DataMap)['list'][0] as DataMap;

  // final tMap = (jsonDecode(tJson) as DataMap)['list'][0] as DataMap;

  test('should be a subclass of Weather', () {
    expect(tModel, isA<Weather>());
  });

  group('fromMap', () {
    test(
      'should return a [WeatherModel] with the right data',
      () {
        // act
        final result = WeatherModel.fromMap(tMap);

        // assert
        //check is that the result is a [WeatherModel] not [Weather] entity
        expect(result, isA<WeatherModel>());
        expect(result, tModel);
      },
    );
    test(
      'should throw an [Error] when the map is invalid',
      () {
        //arrange
        final map = DataMap.from(tMap)..remove('id');
        // act
        const methodCall = WeatherModel.fromMap;

        // assert
        expect(() => methodCall(map), throwsA(isA<Error>()));
      },
    );
  });
}
