import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/weather/domain/repos/weather_repo.dart';
import 'package:weather_app_ca/weather/domain/usecases/get_weather_by_city_id.dart';

import 'weather_repo_mock.dart';

void main() {
  late IWeatherRepo repository;
  late GetWeatherByCityId usecase;

  final tWeather = Weather.empty();
  const tFailure = ServerFailure(
    message: 'No data found for this params',
    statusCode: 500,
  );
  const params = GetWeatherByCityIdParams.empty();

  setUp(() {
    repository = MockWeatherRepo();
    usecase = GetWeatherByCityId(repository);
  });

  group('GetWeatherByCityId', () {
    test(
      'should call the [WeatherRepo.getWeatherByCityId] '
      'and return [Weather] if successfull',
      () async {
        // arrange
        when(
          () => repository.getWeatherByCityId(
            cityId: any(named: 'cityId'),
          ),
        ).thenAnswer((_) async => Right(tWeather));

        // act
        final result = await usecase(params);

        // assert
        expect(result, Right<dynamic, Weather>(tWeather));

        verify(
          () => repository.getWeatherByCityId(
            cityId: params.cityId,
          ),
        ).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
    test(
      'should call the [WeatherRepo.getWeatherByCityId] '
      'and return [ServerFailure] if unsuccessfull',
      () async {
        // arrange
        when(
          () => repository.getWeatherByCityId(
            cityId: any(named: 'cityId'),
          ),
        ).thenAnswer((_) async => const Left(tFailure));

        // act
        final result = await usecase(params);

        // assert
        expect(result, const Left<Failure, dynamic>(tFailure));

        verify(
          () => repository.getWeatherByCityId(
            cityId: params.cityId,
          ),
        ).called(1);

        verifyNoMoreInteractions(repository);
      },
    );
  });
}
