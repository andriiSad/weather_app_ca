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

  WeatherModel.fromMap(DataMap map)
      : super(
          cityId: map['id'] as int,
          temp: (map['main'] as DataMap)['temp'] as double,
          tempMin: (map['main'] as DataMap)['temp_min'] as double,
          tempMax: (map['main'] as DataMap)['temp_max'] as double,
          mainWeatherId: List<DataMap>.from(map['weather'] as List<dynamic>)[0]
              ['id'] as int,
          date: DateFormat('d MMMM y').format(DateTime.now()),
        );

  // factory WeatherModel.fromJson(Map<String, dynamic> json) {
  //   final mainData = json['main'] as Map<String, dynamic>;
  //   final weatherList = json['weather'] as List<dynamic>;

  //   return WeatherModel(
  //     cityId: json['id'] as int,
  //     temp: mainData['temp'] as double,
  //     tempMin: mainData['temp_min'] as double,
  //     tempMax: mainData['temp_max'] as double,
  //     mainWeatherId: weatherList.isNotEmpty
  //         ? (weatherList[0] as Map<String, dynamic>)['id'] as int
  //         : 0, // Default value if weatherList is empty
  //   );
  // }

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
