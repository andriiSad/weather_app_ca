import 'package:equatable/equatable.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';

class City extends Equatable {
  const City({
    required this.id,
    required this.name,
    required this.countryCode,
    required this.coord,
  });

  const City.empty()
      : this(
          id: 0,
          name: '_empty.name_',
          countryCode: '_empty.countryCode_',
          coord: const Coordinates.empty(),
        );

  final int id;
  final String name;
  final String countryCode;
  final Coordinates coord;

  @override
  List<Object> get props => [id];

  @override
  String toString() =>
      'City(id: $id, name: $name, countryCode: $countryCode, coord: $coord)';
}
