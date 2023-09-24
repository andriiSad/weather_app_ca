import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app_ca/core/errors/failures.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/src/weather/domain/entities/weather.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_list_weather.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_city_id.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_coordinates.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({
    required GetListWeather getListWeather,
    required GetWeatherByCityId getWeatherByCityId,
    required GetWeatherByCoordinates getWeatherByCoordinates,
  })  : _getListWeather = getListWeather,
        _getWeatherByCityId = getWeatherByCityId,
        _getWeatherByCoordinates = getWeatherByCoordinates,
        super(const WeatherInitialState()) {
    on<SelectingCityEvent>(_selectingCityEventHandler);
    on<SelectedCityEvent>(_selectedCityEventHandler);
    on<SelectedPopularCityEvent>(_selectedPopularCityEventHandler);
    on<SelectedCityByCoordinatesEvent>(_selectedCityByCoordinatesEventHandler);
  }
  final GetListWeather _getListWeather;
  final GetWeatherByCityId _getWeatherByCityId;
  final GetWeatherByCoordinates _getWeatherByCoordinates;

  Future<void> _selectingCityEventHandler(
    SelectingCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final result = await _getListWeather(
      GetListWeatherParams(
        cityName: event.cityName,
      ),
    );
    result.fold(
      (failure) => emit(
        CitySelectingErrorState(
          statusCode: failure.statusCode,
          message: failure.message,
        ),
      ),
      (weatherList) => emit(
        CitySelectingState(
          weatherList: weatherList,
        ),
      ),
    );
  }

  Future<void> _selectedCityEventHandler(
    SelectedCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final weatherList = (state as CitySelectingState).weatherList;

    emit(const WeatherLoadingState());

    final result = weatherList.firstWhere(
      (weather) => weather.city.id == event.cityId,
    );

    emit(
      WeatherLoadedState(
        weather: result,
      ),
    );
  }

  Future<void> _selectedPopularCityEventHandler(
    SelectedPopularCityEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoadingState());
    final result = await _getWeatherByCityId(
      GetWeatherByCityIdParams(
        cityId: event.cityId,
      ),
    );
    result.fold(
      (failure) => WeatherErrorState(
        statusCode: failure.statusCode,
        message: failure.message,
      ),
      (weather) => emit(
        WeatherLoadedState(
          weather: weather,
        ),
      ),
    );
  }

  Future<void> _selectedCityByCoordinatesEventHandler(
    SelectedCityByCoordinatesEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoadingState());

    final result = await _getWeatherByCoordinates(
      GetWeatherByCoordinatesParams(coord: event.coord),
    );
    result.fold(
      (failure) => WeatherErrorState(
        statusCode: failure.statusCode,
        message: failure.message,
      ),
      (weather) => emit(
        WeatherLoadedState(
          weather: weather,
        ),
      ),
    );
  }
}
