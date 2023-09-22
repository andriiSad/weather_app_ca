import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/domain/entities/city.dart';

class CityModel extends City {
  const CityModel({
    required super.id,
    required super.name,
    required super.countryCode,
    required super.coord,
  });

  const CityModel.empty() : super.empty();

  factory CityModel.fromJson(DataMap json) {
    final dataMap = json['sys'] as DataMap;
    final coordMap = json['coord'] as DataMap;

    return CityModel(
      id: json['id'] as int,
      name: json['name'] as String,
      countryCode: dataMap['country'] as String,
      coord: Coordinates(
        lat: coordMap['lat'] as double,
        lon: coordMap['lon'] as double,
      ),
    );
  }

  // CityModel.fromMap(DataMap map)
  //     : super(
  //         id: map['id'] as int,
  //         name: map['name'] as String,
  //         countryCode: (map['sys'] as DataMap)['country'] as String,
  //         coord: Coordinates(
  //           lat: (map['coord'] as DataMap)['lat'] as double,
  //           lon: (map['coord'] as DataMap)['lon'] as double,
  //         ),
  //       );
}
