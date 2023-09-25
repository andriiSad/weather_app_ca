import 'package:intl/intl.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/src/weather/data/models/city_model.dart';
import 'package:weather_app_ca/src/weather/data/models/main_weather_model.dart';
import 'package:weather_app_ca/src/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.city,
    required super.temp,
    required super.tempMin,
    required super.tempMax,
    required super.mainWeather,
  }) : super(
          date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        );

  const WeatherModel.empty() : super.empty();

  factory WeatherModel.fromMap(DataMap json) {
    final main = json['main'] as Map<String, dynamic>;

    return WeatherModel(
      city: CityModel.fromMap(json),
      temp: main['temp'] as double,
      tempMin: main['temp_min'] as double,
      tempMax: main['temp_max'] as double,
      mainWeather: MainWeatherModel.fromMap(json),
    );
  }

  WeatherModel copyWith({
    CityModel? city,
    double? temp,
    double? tempMin,
    double? tempMax,
    MainWeatherModel? mainWeather,
    String? date,
  }) =>
      WeatherModel(
        city: city ?? this.city,
        temp: temp ?? this.temp,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        mainWeather: mainWeather ?? this.mainWeather,
      );
}
