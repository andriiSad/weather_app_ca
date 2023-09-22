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

  MainWeatherModel.fromMap(DataMap map)
      : super(
          id: map['id'] as int,
          main: map['main'] as String,
          description: map['description'] as String,
          iconCode: map['icon'] as String,
        );
}
