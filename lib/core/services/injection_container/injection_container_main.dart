part of 'injection_container.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  await _initWeather();
}

Future<void> _initWeather() async {
  serviceLocator
    //Buisness Logic
    ..registerFactory(
      () => WeatherBloc(
        getListWeather: serviceLocator(),
        getWeatherByCityId: serviceLocator(),
        getWeatherByCoordinates: serviceLocator(),
      ),
    )

    //Use cases
    ..registerLazySingleton(() => GetListWeather(serviceLocator()))
    ..registerLazySingleton(() => GetWeatherByCityId(serviceLocator()))
    ..registerLazySingleton(() => GetWeatherByCoordinates(serviceLocator()))

    //Repositories
    //because we register interface but passing impl, we specify type
    ..registerLazySingleton<IWeatherRepo>(
      () => WeatherRepoImpl(serviceLocator()),
    )

    //Data Sources
    ..registerLazySingleton<IWeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )

    //External Dependencies
    ..registerLazySingleton(
      http.Client.new,
    );
}
