import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_ca/src/weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather_app_ca/src/weather/data/repos/weather_repo_impl.dart';
import 'package:weather_app_ca/src/weather/domain/repos/weather_repo.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_list_weather.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_city_id.dart';
import 'package:weather_app_ca/src/weather/domain/usecases/get_weather_by_coordinates.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';

part 'injection_container_main.dart';
