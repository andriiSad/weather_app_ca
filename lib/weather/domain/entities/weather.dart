import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Weather extends Equatable {
  Weather({
    required this.cityId,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.mainWeatherId,
  }) : date = DateFormat('d MMMM y').format(DateTime.now());

  Weather.empty()
      : this(
          cityId: 0,
          temp: 0,
          tempMin: 0,
          tempMax: 0,
          mainWeatherId: 0,
        );

  final int cityId;

  final int temp;
  final int tempMin;
  final int tempMax;

  final int mainWeatherId;

  final String date;

  @override
  List<Object> get props => [
        cityId,
        temp,
        tempMin,
        tempMax,
        mainWeatherId,
      ];

  @override
  String toString() =>
      'Weather(cityId: $cityId, temp: $temp, tempMin: $tempMin, '
      'tempMax: $tempMax, mainWeatherId: $mainWeatherId, date: $date)';
}
