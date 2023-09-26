import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/src/weather/domain/entities/city.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_ca/src/weather/presentation/screens/custom_map_screen.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final inputController = TextEditingController();

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: inputController,
                        maxLength: 20,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Start typing to search...',
                          hintStyle: context.textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          counterText: '', // Remove the default counter text
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        FloatingActionButton(
                          heroTag: '_search_icon_',
                          onPressed: () {
                            context.read<WeatherBloc>().add(
                                  SelectingCityEvent(
                                    cityName: inputController.text.trim(),
                                  ),
                                );
                          },
                          shape: const CircleBorder(),
                          child: const Icon(
                            IconlyLight.search,
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: '_map_icon_',
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder<void>(
                                pageBuilder: (_, __, ___) =>
                                    const CustomMapScreen(),
                                transitionsBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  final tween =
                                      Tween<double>(begin: 0.5, end: 1);
                                  final fadeAnimation = animation.drive(tween);
                                  return FadeTransition(
                                    opacity: fadeAnimation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.location_pin,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (state is CitySelectingState)
              _SearchBarDropDown(
                cities:
                    state.weatherList.map((weather) => weather.city).toList(),
                inputController: inputController,
              )
            else if (state is CitySelectingErrorState)
              SizedBox(
                width: double.infinity,
                height: context.screenHeight * 0.1,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Align(
                    child: Text(state.message),
                  ),
                ),
              )
            else
              Container(),
          ],
        );
      },
    );
  }
}

class _SearchBarDropDown extends StatelessWidget {
  const _SearchBarDropDown({
    required this.cities,
    required this.inputController,
  });

  final List<City> cities;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...cities.map(
              (city) => Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      context.locationProvider.coordinates = Coordinates(
                        lat: city.coord.lat,
                        lon: city.coord.lon,
                      );

                      context.read<WeatherBloc>().add(
                            SelectedCityEvent(cityId: city.id),
                          );
                      FocusManager.instance.primaryFocus?.unfocus();

                      inputController.clear();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${city.name}, ${city.countryCode}',
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
