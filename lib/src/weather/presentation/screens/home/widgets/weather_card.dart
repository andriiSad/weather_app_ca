import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({
    super.key,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    final cardHeight = context.screenHeight * 0.55;
    return SizedBox(
      height: cardHeight,
      child: Card(
        color: Colors.white.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<WeatherBloc, WeatherState>(
            buildWhen: (previous, current) =>
                current is! CitySelectingState &&
                current is! CitySelectingErrorState,
            builder: (context, state) {
              if (state is WeatherLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WeatherErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is WeatherLoadedState) {
                var composedName = '${state.weather.city.name}, '
                    '${state.weather.city.countryCode}';
                if (composedName.length > 20) {
                  composedName = composedName.substring(0, 20);
                }
                return Column(
                  children: [
                    SizedBox(
                      height: cardHeight * 0.35,
                      child: Row(
                        children: [
                          _WeatherIcon(
                            imageUrl:
                                'https://openweathermap.org/img/wn/${state.weather.mainWeather.iconCode}.png',
                          ),
                          const Gap(15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.weather.temp < 0
                                      ? '${state.weather.temp.round()}\u2103'
                                      : '+${state.weather.temp.round()}\u2103',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.weather.mainWeather.main,
                                  style: context.textTheme.bodyMedium,
                                ),
                                Text(
                                  state.weather.mainWeather.description,
                                  style: context.textTheme.bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(cardHeight * 0.1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          composedName,
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          state.weather.date,
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    Gap(cardHeight * 0.05),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.blue,
                    ),
                    Gap(cardHeight * 0.05),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Min',
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                state.weather.tempMin < 0
                                    ? '${state.weather.tempMin.round()}\u2103'
                                    : '+${state.weather.tempMin.round()}\u2103',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 0.5,
                            color: Colors.blue,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Max',
                                style: context.textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                state.weather.tempMax < 0
                                    ? '${state.weather.tempMax.round()}\u2103'
                                    : '+${state.weather.tempMax.round()}\u2103',
                                style: context.textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: imageUrl,
        fit: BoxFit.contain,
        width: context.screenHeight * 0.15,
        height: context.screenHeight * 0.15,
      ),
    );
  }
}
