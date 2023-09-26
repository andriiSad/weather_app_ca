import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_ca/core/common/providers/location_provider.dart';
import 'package:weather_app_ca/core/common/providers/theme_provider.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/res/strings.dart';
import 'package:weather_app_ca/core/services/bloc_observer.dart';
import 'package:weather_app_ca/core/services/injection_container/injection_container.dart';
import 'package:weather_app_ca/core/theme/theme.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  Bloc.observer = const AppBlocObserver();

  //dependencies injection
  await init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.themeProvider.initThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<WeatherBloc>(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final themeMode = themeProvider.themeMode;

          return ChangeNotifierProvider(
            create: (_) => LocationProvider(),
            child: MaterialApp(
              title: appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              home: const HomeScreen(),
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
