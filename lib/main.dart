import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_ca/core/res/colors.dart';
import 'package:weather_app_ca/core/res/fonts.dart';
import 'package:weather_app_ca/core/services/injection_container/injection_container.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
        theme: ThemeData(
          fontFamily: Fonts.aeonik,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colours.primaryColour,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
