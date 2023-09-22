import 'package:dartz/dartz.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/core/utils/typedefs.dart';
import 'package:weather_app_ca/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/weather/domain/repos/weather_repo.dart';

class WeatherRepoImpl implements IWeatherRepo {
  WeatherRepoImpl(this._remoteDataSource);

  final IWeatherRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<Weather>> getListWeather({
    required String cityName,
  }) async {
    try {
      final result = await _remoteDataSource.getListWeather(
        cityName: cityName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Weather> getWeatherByCityId({
    required int cityId,
  }) async {
    try {
      final result = await _remoteDataSource.getWeatherByCityId(
        cityId: cityId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Weather> getWeatherByCoordinates({
    required Coordinates coord,
  }) async {
    try {
      final result = await _remoteDataSource.getWeatherByCoordinates(
        coord: coord,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
