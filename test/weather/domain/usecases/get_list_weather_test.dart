import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/weather/domain/repos/weather_repo.dart';
import 'package:weather_app_ca/weather/domain/usecases/get_list_weather.dart';

import 'weather_repo_mock.dart';

void main() {
  late IWeatherRepo repository;
  late GetListWeather usecase;

  final tWeatherList = [const Weather.empty()];
  const tFailure = ServerFailure(
    message: 'No data found for this params',
    statusCode: 500,
  );
  const params = GetListWeatherParams.empty();

  setUp(() {
    repository = MockWeatherRepo();
    usecase = GetListWeather(repository);
  });

  group('GetListWeather', () {
    test(
      'should call the [WeatherRepo.getListWeather] '
      'and return [List<Weather>] if successfull',
      () async {
        // arrange
        when(
          () => repository.getListWeather(
            cityName: any(named: 'cityName'),
          ),
        ).thenAnswer((_) async => Right(tWeatherList));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Right<dynamic, List<Weather>>(tWeatherList));

        verify(
          () => repository.getListWeather(
            cityName: params.cityName,
          ),
        ).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should call the [WeatherRepo.getListWeather] '
      'and return [ServerFailure] if unsuccessfull',
      () async {
        // arrange
        when(
          () => repository.getListWeather(
            cityName: any(named: 'cityName'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await usecase(params);

        // assert
        expect(result, const Left<Failure, dynamic>(tFailure));

        verify(
          () => repository.getListWeather(
            cityName: params.cityName,
          ),
        ).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
  });
}
