import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app_ca/core/errors/exceptions.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/core/utils/constants.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/data/models/weather_model.dart';

abstract class IWeatherRemoteDataSource {
  Future<List<WeatherModel>> getListWeather({
    required String cityName,
  });
  Future<WeatherModel> getWeatherByCityId({
    required int cityId,
  });

  Future<WeatherModel> getWeatherByCoordinates({
    required Coordinates coord,
  });
}

class WeatherRemoteDataSourceImpl implements IWeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<WeatherModel>> getListWeather({
    required String cityName,
  }) async {
    try {
      final response = await _client.get(
        Uri.https(
          kBaseUrl,
          kCitiesEndpoint,
          {
            'q': cityName,
            'appid': kApiKey,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      final dataList = (jsonDecode(response.body) as DataMap)['list'] as List;
      if (dataList.isEmpty) {
        throw ServerException(
          message: 'Empty response list',
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(
        dataList,
      ).map(WeatherModel.fromMap).toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<WeatherModel> getWeatherByCityId({
    required int cityId,
  }) async {
    try {
      final response = await _client.get(
        Uri.https(
          kBaseUrl,
          kWeatherEndpoint,
          {
            'id': cityId,
            'appid': kApiKey,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return WeatherModel.fromMap(jsonDecode(response.body) as DataMap);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<WeatherModel> getWeatherByCoordinates({
    required Coordinates coord,
  }) async {
    try {
      final response = await _client.get(
        Uri.https(
          kBaseUrl,
          kWeatherEndpoint,
          {
            'lat': coord.lat,
            'lon': coord.lon,
            'appid': kApiKey,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return WeatherModel.fromMap(jsonDecode(response.body) as DataMap);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
