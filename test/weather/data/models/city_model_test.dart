import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/src/weather/data/models/city_model.dart';
import 'package:weather_app_ca/src/weather/domain/entities/city.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = CityModel.empty();

  final tJson = fixture('weather_list.json');

  final tMap = ((json.decode(tJson) as DataMap)['list'] as List)[0] as DataMap;

  test('should be a subclass of City', () {
    expect(tModel, isA<City>());
  });

  group('fromMap', () {
    test(
      'should return a [CityModel] with the right data',
      () {
        // act
        final result = CityModel.fromMap(tMap);

        // assert
        //check [CityModel] not [City] entity
        expect(result, isA<CityModel>());
        expect(result, tModel);
      },
    );
    test(
      'should throw an [Error] when the map is invalid',
      () {
        //arrange
        final brokenMap = DataMap.from(tMap)..remove('sys');

        // act
        const methodCall = CityModel.fromMap;

        // assert
        expect(() => methodCall(brokenMap), throwsA(isA<Error>()));
      },
    );
  });
}
