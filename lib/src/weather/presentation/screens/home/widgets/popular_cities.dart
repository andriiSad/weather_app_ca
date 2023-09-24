import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/models/popular_city.dart';
import 'package:weather_app_ca/core/res/strings.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/city_card.dart';

class PopularCititesWidget extends StatelessWidget {
  PopularCititesWidget({
    required this.pageController,
    super.key,
  });
  final PageController pageController;

  final List<PopularCity> popularCities = [
    PopularCity(
      id: 5128638,
      cityName: 'New York',
      backgroundImageName: 'new_york.png',
    ),
    PopularCity(
      id: 292223,
      cityName: 'Dubai',
      backgroundImageName: 'dubai.png',
    ),
    PopularCity(
      id: 2968815,
      cityName: 'Paris',
      backgroundImageName: 'paris.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(context.screenHeight * 0.02),
        Text(
          popularCitiesSectionName,
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(context.screenHeight * 0.05),
        ...popularCities.map(
          (city) => CityCard(
            city: city,
            pageController: pageController,
          ),
        ),
      ],
    );
  }
}
