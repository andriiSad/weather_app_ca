import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/data/models/main_weather_model.dart';
import 'package:weather_app_ca/weather/domain/entities/main_weather.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = MainWeatherModel.empty();

  final tJson = fixture('weather.json');

  //TODO(refactor this cast)
  final tMap = (jsonDecode(tJson) as DataMap)['list'][0]['weather'] as DataMap;

  // final tMap = (jsonDecode(tJson) as DataMap)['list'][0] as DataMap;

  test('should be a subclass of MainWeather', () {
    expect(tModel, isA<MainWeather>());
  });

  group('fromMap', () {
    test(
      'should return a [MainWeatherModel] with the right data',
      () {
        // act
        final result = MainWeatherModel.fromMap(tMap);

        // assert
        //check [MainWeatherModel] not [MainWeather] entity
        expect(result, isA<MainWeatherModel>());
        expect(result, tModel);
      },
    );
    test(
      'should throw an [Error] when the map is invalid',
      () {
        //arrange
        final map = DataMap.from(tMap)..remove('id');
        // act
        const methodCall = MainWeatherModel.fromMap;

        // assert
        expect(() => methodCall(map), throwsA(isA<Error>()));
      },
    );
  });
}
