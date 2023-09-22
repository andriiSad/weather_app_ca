import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/domain/entities/coordinates.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';

abstract class IWeatherRepo {
  //for prompt and weather featching
  ResultFuture<List<Weather>> getListWeather({
    required String cityName,
  });

  //for currentLocation feature
  ResultFuture<Weather> getWeatherByCoordinates({
    required Coordinates coord,
  });
  //for popularCities feature
  ResultFuture<Weather> getWeatherByCityId({
    required int cityId,
  });
}
