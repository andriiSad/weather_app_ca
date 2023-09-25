import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_ca/core/services/bloc_observer.dart';
import 'package:weather_app_ca/core/services/injection_container/injection_container.dart';
import 'package:weather_app_ca/core/theme/theme.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  Bloc.observer = const AppBlocObserver();

  //dependencies injection
  await init();

  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<WeatherBloc>(),
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
