import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/footer.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/popular_cities.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/search_bar.dart'
    as widgets;
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
    _setCurrentWeather();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      Container(
        height: context.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_day.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //TODO(fix scroll)
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  Gap(context.screenHeight * 0.1),
                  Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: context.screenHeight * 0.2),
                        child: const WeatherCard(),
                      ),
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: widgets.SearchBar(),
                      ),
                    ],
                  ),
                  Gap(context.screenHeight * 0.2),
                ],
              ),
            ),
          ),
        ),
      ),
      Container(
        height: context.screenHeight,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SafeArea(
              child: PopularCititesWidget(pageController: pageController),
            ),
            const Footer(),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: PageView.builder(
        itemCount: pages.length,
        controller: pageController,
        scrollDirection: Axis.vertical,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return pages[index];
        },
      ),
    );
  }

  Future<void> _setCurrentWeather() async {
    try {
      final determinePosition = await _determinePosition();

      if (context.mounted) {
        context.read<WeatherBloc>().add(
              SelectedCityByCoordinatesEvent(
                coord: Coordinates(
                  lat: determinePosition.latitude,
                  lon: determinePosition.longitude,
                ),
              ),
            );
      }
    } catch (e) {
      if (context.mounted) {
        _showLocationDisabledSnackBar(e.toString());
        context
            .read<WeatherBloc>()
            .add(const SelectedPopularCityEvent(cityId: 2968815));
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, '
        'we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return Geolocator.getCurrentPosition();
  }

  void _showLocationDisabledSnackBar(String text) {
    context.scaffoldMessenger.showSnackBar(
      SnackBar(
        backgroundColor: context.theme.primaryColor,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
          bottom: context.screenHeight * 0.8,
          right: 20,
          left: 20,
        ),
        content: Text(
          text,
        ),
      ),
    );
  }
}
