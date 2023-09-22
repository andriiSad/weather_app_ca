import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/domain/entities/main_weather.dart';

class MainWeatherModel extends MainWeather {
  const MainWeatherModel({
    required super.id,
    required super.main,
    required super.description,
    required super.iconCode,
  });

  const MainWeatherModel.empty() : super.empty();

  factory MainWeatherModel.fromMap(DataMap json) {
    final weather = (json['weather'] as List<dynamic>)[0] as DataMap;

    return MainWeatherModel(
      id: weather['id'] as int,
      main: weather['main'] as String,
      description: weather['description'] as String,
      iconCode: weather['icon'] as String,
    );
  }
}
