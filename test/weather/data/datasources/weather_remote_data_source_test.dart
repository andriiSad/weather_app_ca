import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';
import 'package:weather_app_ca/core/utils/constants.dart';
import 'package:weather_app_ca/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_ca/weather/data/models/weather_model.dart';
import 'package:weather_app_ca/weather/domain/usecases/get_list_weather.dart';

import '../../../fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late IWeatherRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = WeatherRemoteDataSourceImpl(client);
  });

  group('getListWeather', () {
    final tJson = fixture('weather.json');

    const params = GetListWeatherParams.empty();

    setUp(() {
      registerFallbackValue(
        Uri.https(kBaseUrl, kCitiesEndpoint, {
          'q': params.cityName,
          'appid': kApiKey,
        }),
      );
    });

    test(
      'should call the [RemoteDataSource.getListWeather] '
      'and return [List<WeatherModel>] when the status code is 200',
      () async {
        final tWeatherList = [
          const WeatherModel.empty().copyWith(
            date: DateFormat('d MMMM y').format(DateTime.now()),
          ),
        ];

        // arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(tJson, 200),
        );

        // act
        final result = await remoteDataSource.getListWeather(
          cityName: params.cityName,
        );

        // assert
        expect(result, tWeatherList);

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kCitiesEndpoint, {
              'q': params.cityName,
              'appid': kApiKey,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
    test(
      'should throw [ServerException] when the status code is not 200',
      () async {
        const tMessage = 'Server down, Server down, Server down';
        const tStatusCode = 500;

        // arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(
            tMessage,
            tStatusCode,
          ),
        );

        // act
        final methodCall = remoteDataSource.getListWeather;

        // assert
        expect(
          methodCall(
            cityName: params.cityName,
          ),
          throwsA(
            const ServerException(
              message: tMessage,
              statusCode: tStatusCode,
            ),
          ),
        );

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kCitiesEndpoint, {
              'q': params.cityName,
              'appid': kApiKey,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
    test(
        "should throw [ServerException] when the response.body['list'] is empty",
        () async {
      // Arrange
      const tEmptyJson = '{"list": []}';
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(tEmptyJson, 200),
      );

      // Act
      final methodCall = remoteDataSource.getListWeather;

      // Assert
      expect(
        methodCall(
          cityName: params.cityName,
        ),
        throwsA(
          const ServerException(
            message: 'Empty response list',
            statusCode: 200,
          ),
        ),
      );

      verify(
        () => client.get(
          Uri.https(kBaseUrl, kCitiesEndpoint, {
            'q': params.cityName,
            'appid': kApiKey,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
