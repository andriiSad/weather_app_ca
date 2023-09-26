part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

final class SelectingCityEvent extends WeatherEvent {
  const SelectingCityEvent({
    required this.cityName,
  });
  final String cityName;

  @override
  List<String> get props => [cityName];
}

final class SelectedCityEvent extends WeatherEvent {
  const SelectedCityEvent({
    required this.cityId,
  });

  final int cityId;

  @override
  List<int> get props => [cityId];
}

final class SelectedCityByCoordinatesEvent extends WeatherEvent {
  const SelectedCityByCoordinatesEvent({
    required this.coord,
  });

  final Coordinates coord;
}

final class SelectedPopularCityEvent extends WeatherEvent {
  const SelectedPopularCityEvent({
    required this.cityId,
  });

  final int cityId;
}

final class LoadingEvent extends WeatherEvent {
  const LoadingEvent();
}
