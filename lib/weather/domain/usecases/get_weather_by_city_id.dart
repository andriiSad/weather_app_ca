import 'package:weather_app_ca/core/usecases/usecases.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/weather/domain/repos/weather_repo.dart';

class GetWeatherByCityId
    extends UsecaseWithParams<Weather, GetWeatherByCityIdParams> {
  GetWeatherByCityId(this._repo);

  final IWeatherRepo _repo;

  @override
  ResultFuture<Weather> call(GetWeatherByCityIdParams params) async =>
      _repo.getWeatherByCityId(
        cityId: params.cityId,
      );
}

class GetWeatherByCityIdParams {
  const GetWeatherByCityIdParams({required this.cityId});

  const GetWeatherByCityIdParams.empty() : this(cityId: 0);

  final int cityId;
}
