import 'package:intl/intl.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  //TODO:(think about date initialization)
  WeatherModel({
    required super.cityId,
    required super.temp,
    required super.tempMin,
    required super.tempMax,
    required super.mainWeatherId,
  }) : super(
          date: DateFormat('d MMMM y').format(DateTime.now()),
        );

  const WeatherModel.empty() : super.empty();

  factory WeatherModel.fromMap(DataMap json) {
    final main = json['main'] as Map<String, dynamic>;

    return WeatherModel(
      cityId: json['id'] as int,
      temp: main['temp'] as double,
      tempMin: main['temp_min'] as double,
      tempMax: main['temp_max'] as double,
      mainWeatherId: ((json['weather'] as List<dynamic>)[0]
          as Map<String, dynamic>)['id'] as int,
    );
  }

  WeatherModel copyWith({
    int? cityId,
    double? temp,
    double? tempMin,
    double? tempMax,
    int? mainWeatherId,
    String? date,
  }) =>
      WeatherModel(
        cityId: cityId ?? this.cityId,
        temp: temp ?? this.temp,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        mainWeatherId: mainWeatherId ?? this.mainWeatherId,
      );
}
