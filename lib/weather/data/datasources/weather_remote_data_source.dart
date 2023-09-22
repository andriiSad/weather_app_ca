import 'package:weather_app_ca/core/models/coordinates.dart';
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
