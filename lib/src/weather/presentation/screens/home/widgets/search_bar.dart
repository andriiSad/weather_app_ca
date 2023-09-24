import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/src/weather/domain/entities/city.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';

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
                          onPressed: () {
                            context.read<WeatherBloc>().add(
                                  SelectingCityEvent(
                                    cityName: inputController.text.trim(),
                                  ),
                                );
                          },
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.map_outlined,
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
              Text(state.message)
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
                      context.read<WeatherBloc>().add(
                            SelectedCityEvent(cityId: city.id),
                          );

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
