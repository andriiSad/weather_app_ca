import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_ca/weather/data/models/weather_model.dart';
import 'package:weather_app_ca/weather/data/repos/weather_repo_impl.dart';
import 'package:weather_app_ca/weather/domain/usecases/get_list_weather.dart';
import 'package:weather_app_ca/weather/domain/usecases/get_weather_by_city_id.dart';
import 'package:weather_app_ca/weather/domain/usecases/get_weather_by_coordinates.dart';

import 'weather_remote_data_source_mock.dart';

void main() {
  late IWeatherRemoteDataSource remoteDataSource;
  late WeatherRepoImpl repoImpl;

  setUp(() {
    remoteDataSource = MockWeatherRemoteDataSource();
    repoImpl = WeatherRepoImpl(remoteDataSource);
  });

  group('getListWeather', () {
    const params = GetListWeatherParams.empty();

    const tList = [WeatherModel.empty()];

    const tException = ServerException(
      message: 'Unknown error occurred',
      statusCode: '500',
    );
    test(
      'should call the [RemoteDataSource.getListWeather] and return '
      '[List<WeatherModel>], when the call to remote source is successful',
      () async {
        //arrange
        when(
          () => remoteDataSource.getListWeather(
            cityName: any(named: 'cityName'),
          ),
        ).thenAnswer((_) async => tList);

        //act
        final result = await repoImpl.getListWeather(
          cityName: params.cityName,
        );

        //assert
        expect(result, const Right<dynamic, List<WeatherModel>>(tList));

        //check that remote source's getListWeather is get called
        verify(
          () => remoteDataSource.getListWeather(
            cityName: params.cityName,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return a [ServerFailure] '
      'when the call to remote source is unsuccessful',
      () async {
        //arrange
        when(
          () => remoteDataSource.getListWeather(
            cityName: any(named: 'cityName'),
          ),
        ).thenThrow(tException);

        //act
        final result = await repoImpl.getListWeather(
          cityName: params.cityName,
        );

        //assert
        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(
              tException,
            ),
          ),
        );

        //check that remote source's getListWeather is get called
        verify(
          () => remoteDataSource.getListWeather(
            cityName: params.cityName,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
  group('getWeatherByCityId', () {
    const params = GetWeatherByCityIdParams.empty();

    const tModel = WeatherModel.empty();

    const tException = ServerException(
      message: 'Unknown error occurred',
      statusCode: '500',
    );
    test(
      'should call the [RemoteDataSource.getWeatherByCityId] and return '
      '[WeatherModel], when the call to remote source is successful',
      () async {
        //arrange
        when(
          () => remoteDataSource.getWeatherByCityId(
            cityId: any(named: 'cityId'),
          ),
        ).thenAnswer((_) async => tModel);

        //act
        final result = await repoImpl.getWeatherByCityId(
          cityId: params.cityId,
        );

        //assert
        expect(result, const Right<dynamic, WeatherModel>(tModel));

        //check that remote source's getWeatherByCityId is get called
        verify(
          () => remoteDataSource.getWeatherByCityId(
            cityId: params.cityId,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return a [ServerFailure] '
      'when the call to remote source is unsuccessful',
      () async {
        //arrange
        when(
          () => remoteDataSource.getWeatherByCityId(
            cityId: any(named: 'cityId'),
          ),
        ).thenThrow(tException);

        //act
        final result = await repoImpl.getWeatherByCityId(
          cityId: params.cityId,
        );

        //assert
        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(
              tException,
            ),
          ),
        );

        //check that remote source's getWeatherByCityId is get called
        verify(
          () => remoteDataSource.getWeatherByCityId(
            cityId: params.cityId,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
  group('getWeatherByCoordinates', () {
    const params = GetWeatherByCoordinatesParams.empty();

    const tModel = WeatherModel.empty();

    const tException = ServerException(
      message: 'Unknown error occurred',
      statusCode: '500',
    );

    setUp(() {
      registerFallbackValue(params.coord);
    });
    test(
      'should call the [RemoteDataSource.getWeatherByCoordinates] and return '
      '[WeatherModel], when the call to remote source is successful',
      () async {
        //arrange
        when(
          () => remoteDataSource.getWeatherByCoordinates(
            coord: any(named: 'coord'),
          ),
        ).thenAnswer((_) async => tModel);

        //act
        final result = await repoImpl.getWeatherByCoordinates(
          coord: params.coord,
        );

        //assert
        expect(result, const Right<dynamic, WeatherModel>(tModel));

        //check that remote source's getWeatherByCoordinates is get called
        verify(
          () => remoteDataSource.getWeatherByCoordinates(
            coord: params.coord,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return a [ServerFailure] '
      'when the call to remote source is unsuccessful',
      () async {
        //arrange
        when(
          () => remoteDataSource.getWeatherByCoordinates(
            coord: any(named: 'coord'),
          ),
        ).thenThrow(tException);

        //act
        final result = await repoImpl.getWeatherByCoordinates(
          coord: params.coord,
        );

        //assert
        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(
              tException,
            ),
          ),
        );

        //check that remote source's getWeatherByCoordinates is get called
        verify(
          () => remoteDataSource.getWeatherByCoordinates(
            coord: params.coord,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
