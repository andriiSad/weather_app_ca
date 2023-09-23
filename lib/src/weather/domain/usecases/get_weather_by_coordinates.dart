import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/core/usecases/usecases.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/src/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/src/weather/domain/repos/weather_repo.dart';

class GetWeatherByCoordinates
    extends UsecaseWithParams<Weather, GetWeatherByCoordinatesParams> {
  GetWeatherByCoordinates(this._repo);

  final IWeatherRepo _repo;

  @override
  ResultFuture<Weather> call(GetWeatherByCoordinatesParams params) async =>
      _repo.getWeatherByCoordinates(
        coord: params.coord,
      );
}

class GetWeatherByCoordinatesParams {
  const GetWeatherByCoordinatesParams({required this.coord});

  const GetWeatherByCoordinatesParams.empty()
      : this(coord: const Coordinates.empty());

  final Coordinates coord;
}
