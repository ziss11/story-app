import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/cubit/location/location_cubit.dart';
import 'package:story_app/data/model/map_result.dart';
import 'package:story_app/presentation/widgets/app_button.dart';
import 'package:story_app/presentation/widgets/placemark_widget.dart';
import 'package:story_app/utils/styles/app_colors.dart';

import '../../utils/common.dart';

class MapsPage extends StatefulWidget {
  static const mapsPath = 'maps';
  static const mapsRouteName = 'maps';

  static const pickPath = 'pick-location';
  static const pickRouteName = 'pick-location';

  final bool pick;
  final LatLng? latLang;

  const MapsPage({
    super.key,
    required this.pick,
    this.latLang,
  });

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  @override
  void initState() {
    Future.microtask(() async {
      if (widget.pick) {
        context.read<LocationCubit>().defineMyLocation();
      } else {
        context.read<LocationCubit>().setLocation(widget.latLang!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foregroundColor,
      body: SafeArea(
        child: Center(
          child: BlocBuilder<LocationCubit, LocationState>(
            builder: (context, state) {
              if (state is LocationUpdated) {
                return Stack(
                  children: [
                    GoogleMap(
                      markers: state.markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: state.latLng,
                        zoom: 18,
                      ),
                      onMapCreated: context.read<LocationCubit>().onMapCreated,
                      onTap: (widget.pick)
                          ? context.read<LocationCubit>().setLocation
                          : null,
                    ),
                    Positioned(
                      right: 16,
                      bottom: (!widget.pick)
                          ? 130
                          : (state.placemark != null)
                              ? 180
                              : 16,
                      child: Column(
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'zoom-in',
                            backgroundColor: AppColors.foregroundColor,
                            onPressed: () async {
                              final controller = await context
                                  .read<LocationCubit>()
                                  .mapController
                                  ?.future;
                              controller?.animateCamera(CameraUpdate.zoomIn());
                            },
                            child: const Icon(Icons.add),
                          ),
                          FloatingActionButton.small(
                            heroTag: 'zoom-out',
                            backgroundColor: AppColors.foregroundColor,
                            onPressed: () async {
                              final controller = await context
                                  .read<LocationCubit>()
                                  .mapController
                                  ?.future;
                              controller?.animateCamera(CameraUpdate.zoomOut());
                            },
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: FloatingActionButton.small(
                        heroTag: 'back',
                        backgroundColor: AppColors.foregroundColor,
                        onPressed: context.pop,
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    if (widget.pick)
                      Positioned(
                        right: 16,
                        top: 16,
                        child: FloatingActionButton.small(
                          heroTag: 'my-location',
                          backgroundColor: AppColors.foregroundColor,
                          onPressed:
                              context.read<LocationCubit>().defineMyLocation,
                          child: const Icon(Icons.my_location),
                        ),
                      ),
                    if (state.placemark != null)
                      Positioned(
                        bottom: 30,
                        right: 16,
                        left: 16,
                        child: Column(
                          children: [
                            PlacemarkWidget(
                              placemark: state.placemark!,
                            ),
                            const SizedBox(height: 8),
                            if (widget.pick)
                              AppButton(
                                width: MediaQuery.of(context).size.width,
                                onPressed: () => context.pop(
                                  MapsResult(
                                    placemark: state.placemark,
                                    latLng: state.latLng,
                                  ),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.save,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
