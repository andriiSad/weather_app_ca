import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/src/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/src/weather/domain/repos/weather_repo.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_coordinates.dart';

import 'weather_repo_mock.dart';

void main() {
  late IWeatherRepo repository;
  late GetWeatherByCoordinates usecase;

  const tWeather = Weather.empty();
  const tFailure = ServerFailure(
    message: 'No data found for this params',
    statusCode: 500,
  );
  const params = GetWeatherByCoordinatesParams.empty();

  setUp(() {
    repository = MockWeatherRepo();
    usecase = GetWeatherByCoordinates(repository);
    registerFallbackValue(params.coord);
  });

  group('GetWeatherByCoordinates', () {
    test(
      'should call the [WeatherRepo.getWeatherByCoordinates] '
      'and return [Weather] if successfull',
      () async {
        // arrange
        when(
          () => repository.getWeatherByCoordinates(
            coord: any(named: 'coord'),
          ),
        ).thenAnswer((_) async => const Right(tWeather));

        // act
        final result = await usecase(params);

        // assert
        expect(result, const Right<dynamic, Weather>(tWeather));

        verify(
          () => repository.getWeatherByCoordinates(
            coord: params.coord,
          ),
        ).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should call the [WeatherRepo.getWeatherByCoordinates] '
      'and return [ServerFailure] if unsuccessfull',
      () async {
        // arrange
        when(
          () => repository.getWeatherByCoordinates(
            coord: any(named: 'coord'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await usecase(params);

        // assert
        expect(result, const Left<Failure, dynamic>(tFailure));

        verify(
          () => repository.getWeatherByCoordinates(
            coord: params.coord,
          ),
        ).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
  });
}
