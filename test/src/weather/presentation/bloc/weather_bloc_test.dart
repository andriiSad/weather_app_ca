import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_list_weather.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_city_id.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_coordinates.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';

class MockGetListWeather extends Mock implements GetListWeather {}

class MockGetWeatherByCityId extends Mock implements GetWeatherByCityId {}

class MockGetWeatherByCoordinates extends Mock
    implements GetWeatherByCoordinates {}

void main() {
  late GetListWeather getListWeather;
  late GetWeatherByCityId getWeatherByCityId;
  late GetWeatherByCoordinates getWeatherByCoordinates;

  late WeatherBloc bloc;

  const tGetListWeatherParams = GetListWeatherParams.empty();
  const tGetWeatherByCityIdParams = GetWeatherByCityIdParams.empty();
  const tGetWeatherByCoordinatesParams = GetWeatherByCoordinatesParams.empty();

  const tFailure = ServerFailure(message: 'Unknown failure', statusCode: 505);

  setUp(() {
    getListWeather = MockGetListWeather();
    getWeatherByCityId = MockGetWeatherByCityId();
    getWeatherByCoordinates = MockGetWeatherByCoordinates();

    bloc = WeatherBloc(
      getListWeather: getListWeather,
      getWeatherByCityId: getWeatherByCityId,
      getWeatherByCoordinates: getWeatherByCoordinates,
    );
  });

  //always close the bloc
  tearDown(() => bloc.close());

  test(
    'initial state should be [WeatherInitialState]',
    () async => expect(bloc.state, const WeatherInitialState()),
  );
}
