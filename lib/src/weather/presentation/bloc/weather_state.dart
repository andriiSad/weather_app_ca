part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitialState extends WeatherState {
  const WeatherInitialState();
}

final class CitySelectingState extends WeatherState {
  const CitySelectingState({required this.weatherList});

  final List<Weather> weatherList;

  @override
  List<Object> get props => [];
}

final class WeatherLoadingState extends WeatherState {
  const WeatherLoadingState();
}

final class WeatherLoadedState extends WeatherState {
  const WeatherLoadedState({
    required this.weather,
  });

  final Weather weather;

  @override
  List<Object> get props => [weather];
}

final class WeatherErrorState extends WeatherState {
  const WeatherErrorState({
    required this.statusCode,
    required this.message,
  });

  factory WeatherErrorState.fromFailure(Failure failure) => WeatherErrorState(
        statusCode: failure.statusCode,
        message: 'Error: ${failure.message}',
      );

  final int statusCode;
  final String message;

  @override
  List<Object> get props => [statusCode, message];
}

final class CitySelectingErrorState extends WeatherState {
  const CitySelectingErrorState({
    required this.statusCode,
    required this.message,
  });

  factory CitySelectingErrorState.fromFailure(Failure failure) =>
      CitySelectingErrorState(
        statusCode: failure.statusCode,
        message: failure.message,
      );

  final int statusCode;
  final String message;

  @override
  List<Object> get props => [statusCode, message];
}
