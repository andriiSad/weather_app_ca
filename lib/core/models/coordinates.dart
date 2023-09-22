import 'package:equatable/equatable.dart';

class Coordinates extends Equatable {
  const Coordinates({
    required this.lat,
    required this.lon,
  });

  const Coordinates.empty() : this(lat: 0, lon: 0);

  final double lat;
  final double lon;

  @override
  List<double> get props => [lat, lon];

  @override
  String toString() => 'Coordinates(lat: $lat, lon: $lon)';
}
