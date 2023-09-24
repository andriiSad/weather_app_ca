import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/search_bar.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/home/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              child: Column(
                children: [
                  Gap(context.screenHeight * 0.1),
                  const SearhBar(),
                  Gap(context.screenHeight * 0.1),
                  const WeatherCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
