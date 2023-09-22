import 'package:weather_app_ca/core/usecases/usecases.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/weather/domain/repos/weather_repo.dart';

class GetListWeather
    extends UsecaseWithParams<List<Weather>, GetListWeatherParams> {
  GetListWeather(this._repo);

  final IWeatherRepo _repo;

  @override
  ResultFuture<List<Weather>> call(GetListWeatherParams params) async =>
      _repo.getListWeather(
        cityName: params.cityName,
      );
}

class GetListWeatherParams {
  const GetListWeatherParams({required this.cityName});

  const GetListWeatherParams.empty() : this(cityName: '_empty.cityName_');

  final String cityName;
}
