import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/exceptions.dart';
import 'package:weather_app_ca/core/utils/constants.dart';
import 'package:weather_app_ca/src/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_ca/src/weather/data/models/weather_model.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_list_weather.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_city_id.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_coordinates.dart';

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
    final tJson = fixture('weather_list.json');

    const params = GetListWeatherParams.empty();

    setUp(() {
      registerFallbackValue(
        Uri.https(kBaseUrl, kCitiesEndpoint, {
          'q': params.cityName,
          'units': 'metric',
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
              'units': 'metric',
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
              'units': 'metric',
              'appid': kApiKey,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
    test("should throw [ServerException] when the response.body['list'] empty",
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
          isA<ServerException>(),
        ),
      );

      verify(
        () => client.get(
          Uri.https(kBaseUrl, kCitiesEndpoint, {
            'q': params.cityName,
            'units': 'metric',
            'appid': kApiKey,
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
  group('getWeatherByCityId', () {
    final tJson = fixture('single_weather.json');

    const params = GetWeatherByCityIdParams.empty();

    setUp(() {
      registerFallbackValue(
        Uri.https(kBaseUrl, kWeatherEndpoint, {
          'id': params.cityId.toString(),
          'units': 'metric',
          'appid': kApiKey,
        }),
      );
    });

    test(
      'should call the [RemoteDataSource.getWeatherByCityId] '
      'and return [WeatherModel] when the status code is 200',
      () async {
        final tModel = const WeatherModel.empty().copyWith(
          date: DateFormat('d MMMM y').format(DateTime.now()),
        );

        // arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(tJson, 200),
        );

        // act
        final result = await remoteDataSource.getWeatherByCityId(
          cityId: params.cityId,
        );

        // assert
        expect(result, tModel);

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kWeatherEndpoint, {
              'id': params.cityId.toString(),
              'units': 'metric',
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
        final methodCall = remoteDataSource.getWeatherByCityId;

        // assert
        expect(
          methodCall(
            cityId: params.cityId,
          ),
          throwsA(
            isA<ServerException>(),
          ),
        );

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kWeatherEndpoint, {
              'id': params.cityId.toString(),
              'units': 'metric',
              'appid': kApiKey,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
  group('getWeatherByCoordinates', () {
    final tJson = fixture('single_weather.json');

    const params = GetWeatherByCoordinatesParams.empty();

    setUp(() {
      registerFallbackValue(
        Uri.https(kBaseUrl, kWeatherEndpoint, {
          'lat': params.coord.lat.toString(),
          'lon': params.coord.lon.toString(),
          'units': 'metric',
          'appid': kApiKey,
        }),
      );
    });

    test(
      'should call the [RemoteDataSource.getWeatherByCoordinates] '
      'and return [WeatherModel] when the status code is 200',
      () async {
        final tModel = const WeatherModel.empty().copyWith(
          date: DateFormat('d MMMM y').format(DateTime.now()),
        );

        // arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(tJson, 200),
        );

        // act
        final result = await remoteDataSource.getWeatherByCoordinates(
          coord: params.coord,
        );

        // assert
        expect(result, tModel);

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kWeatherEndpoint, {
              'lat': params.coord.lat.toString(),
              'lon': params.coord.lon.toString(),
              'units': 'metric',
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
        final methodCall = remoteDataSource.getWeatherByCoordinates;

        // assert
        expect(
          methodCall(
            coord: params.coord,
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
            Uri.https(kBaseUrl, kWeatherEndpoint, {
              'lat': params.coord.lat.toString(),
              'lon': params.coord.lon.toString(),
              'units': 'metric',
              'appid': kApiKey,
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });
}
