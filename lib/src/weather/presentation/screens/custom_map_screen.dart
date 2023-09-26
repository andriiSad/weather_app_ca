import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';
import 'package:weather_app_ca/core/extensions/context_extension.dart';
import 'package:weather_app_ca/core/models/coordinates.dart';
import 'package:weather_app_ca/src/weather/presentation/bloc/weather_bloc.dart';

class CustomMapScreen extends StatefulWidget {
  const CustomMapScreen({super.key});

  @override
  State<CustomMapScreen> createState() => _CustomMapScreenState();
}

class _CustomMapScreenState extends State<CustomMapScreen> {
  late Completer<GoogleMapController> _googleMapController;
  late CameraPosition? _cameraPosition;
  late Marker _marker;
  late LatLng _userPosition;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _googleMapController.future.then((value) {
      value.dispose();
    });
    super.dispose();
  }

  void _init() {
    _googleMapController = Completer();
    _userPosition = LatLng(
      context.locationProvider.coordinates?.lat ?? 50.450001,
      context.locationProvider.coordinates?.lon ?? 30.524444,
    );
    _cameraPosition = CameraPosition(
      target: _userPosition,
      zoom: 14,
    );

    _marker = Marker(
      markerId: const MarkerId('center_marker'),
      position: _cameraPosition!.target,
      draggable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition!,
            onMapCreated: (GoogleMapController controller) {
              if (!_googleMapController.isCompleted) {
                _googleMapController.complete(controller);
              }
            },
            markers: {_marker},
            onCameraMove: _onCameraMove,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_pin),
                      TextButton(
                        onPressed: () => _onMarkerTapped(context),
                        child: const Text(
                          'Pick this location',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            left: 5,
            right: 5,
            child: SafeArea(
              child: _CustomMapSearchBar(
                userPosition: _userPosition,
                googleMapController: _googleMapController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _marker = _marker.copyWith(
        positionParam: position.target,
      );
    });
  }

  void _onMarkerTapped(BuildContext context) {
    context.locationProvider.coordinates = Coordinates(
      lat: _marker.position.latitude,
      lon: _marker.position.longitude,
    );

    context.read<WeatherBloc>().add(
          SelectedCityByCoordinatesEvent(
            coord: Coordinates(
              lat: _marker.position.latitude,
              lon: _marker.position.longitude,
            ),
          ),
        );
    Navigator.of(context).pop();
  }
}

class _CustomMapSearchBar extends StatelessWidget {
  const _CustomMapSearchBar({
    required LatLng userPosition,
    required Completer<GoogleMapController> googleMapController,
  })  : _userPosition = userPosition,
        _googleMapController = googleMapController;

  final LatLng _userPosition;
  final Completer<GoogleMapController> _googleMapController;

  @override
  Widget build(BuildContext context) {
    return SearchMapPlaceWidget(
      apiKey: FlutterConfig.get('GOOGLE_MAPS_API_KEY') as String,
      bgColor: Colors.white,
      textColor: Colors.black,
      iconColor: Colors.black,

      // The position used to give better recomendations.
      // In this case we are using the user position
      location: _userPosition,
      radius: 30000,
      onSelected: (Place place) async {
        final geolocation = await place.geolocation;
        final controller = await _googleMapController.future;

        // Will animate the GoogleMap camera,
        //taking us to the selected position with an appropriate zoom
        await controller.animateCamera(
          CameraUpdate.newLatLng(
            geolocation!.coordinates as LatLng,
          ),
        );
        await controller.animateCamera(
          CameraUpdate.newLatLngBounds(
            geolocation.bounds as LatLngBounds,
            0,
          ),
        );
      },
    );
  }
}
