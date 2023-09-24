import 'package:equatable/equatable.dart';
import 'package:weather_app_ca/src/weather/domain/entities/city.dart';
import 'package:weather_app_ca/src/weather/domain/entities/main_weather.dart';

class Weather extends Equatable {
  const Weather({
    required this.city,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.mainWeather,
    required this.date,
  });

  const Weather.empty()
      : this(
          city: const City.empty(),
          temp: 0,
          tempMin: 0,
          tempMax: 0,
          mainWeather: const MainWeather.empty(),
          date: '',
        );

  final City city;

  final double temp;
  final double tempMin;
  final double tempMax;

  final MainWeather mainWeather;

  final String date;

  @override
  List<Object> get props => [
        city,
        temp,
        tempMin,
        tempMax,
        mainWeather,
        date,
      ];

  @override
  String toString() => 'Weather(city: $city, temp: $temp, tempMin: $tempMin, '
      'tempMax: $tempMax, mainWeather: $mainWeather, date: $date)';
}
