import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  const Weather({
    required this.cityId,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.mainWeatherId,
    required this.date,
  });

  const Weather.empty()
      : this(
          cityId: 0,
          temp: 0,
          tempMin: 0,
          tempMax: 0,
          mainWeatherId: 0,
          date: '',
        );

  final int cityId;

  final double temp;
  final double tempMin;
  final double tempMax;

  final int mainWeatherId;

  final String date;

  @override
  List<Object> get props => [
        cityId,
        temp,
        tempMin,
        tempMax,
        mainWeatherId,
        date,
      ];

  @override
  String toString() =>
      'Weather(cityId: $cityId, temp: $temp, tempMin: $tempMin, '
      'tempMax: $tempMax, mainWeatherId: $mainWeatherId, date: $date)';
}
