import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
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
  void initState() {
    context.read<WeatherBloc>().add(
          const SelectedCityByCoordinatesEvent(
            coord: Coordinates(
              lat: 50.06143,
              lon: 19.93658,
            ),
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardHeight = context.screenHeight * 0.4;
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
                return Column(
                  children: [
                    SizedBox(
                      height: cardHeight * 0.3,
                      child: const Row(
                        children: [
                          _WeatherIcon(
                            imageUrl:
                                'https://openweathermap.org/img/wn/02d.png',
                          ),
                          Gap(15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('One'),
                                Text('Two'),
                                Text('Three'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(cardHeight * 0.1),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Three'),
                        Text('Four'),
                      ],
                    ),
                    Gap(cardHeight * 0.1),
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
                              const Text('One'),
                              Text(state.weather.tempMin.toString()),
                            ],
                          ),
                          const VerticalDivider(
                            thickness: 0.5,
                            color: Colors.blue,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text('One'),
                              Text(state.weather.tempMax.toString()),
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
      child: Image.network(
        imageUrl,
        scale: 0.5,
      ),
    );
  }
}
