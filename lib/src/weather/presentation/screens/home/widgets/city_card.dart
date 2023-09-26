import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/models/popular_city.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    required this.city,
    required this.pageController,
    super.key,
  });

  final PopularCity city;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: context.screenHeight * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/${city.backgroundImageName}',
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.white.withOpacity(0.7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    context
                        .read<WeatherBloc>()
                        .add(SelectedPopularCityEvent(cityId: city.id));
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    city.cityName,
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
