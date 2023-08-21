import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/cubit/location_picker/location_picker_cubit.dart';
import 'package:story_app/data/model/map_result.dart';
import 'package:story_app/presentation/widgets/app_button.dart';
import 'package:story_app/presentation/widgets/placemark_widget.dart';
import 'package:story_app/utils/styles/app_colors.dart';

import '../../utils/common.dart';

class LocationPickerPage extends StatefulWidget {
  static const path = 'pick-location';
  static const routeName = 'location-picker';

  const LocationPickerPage({super.key});

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  @override
  void initState() {
    Future.microtask(
      () async => context.read<LocationPickerCubit>().defineMyLocation(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foregroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        iconTheme: const IconThemeData(color: AppColors.blackColor1),
        title: Text(
          AppLocalizations.of(context)!.pickLocationLabel,
          style: const TextStyle(
            color: AppColors.blackColor1,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<LocationPickerCubit, LocationPickerState>(
            builder: (context, state) {
              if (state is LocationPickerLocationUpdated) {
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
                      onMapCreated:
                          context.read<LocationPickerCubit>().onMapCreated,
                      onTap: context.read<LocationPickerCubit>().setLocation,
                    ),
                    Positioned(
                      right: 16,
                      bottom: state.placemark != null ? 180 : 16,
                      child: Column(
                        children: [
                          FloatingActionButton.small(
                            heroTag: 'zoom-in',
                            backgroundColor: AppColors.foregroundColor,
                            onPressed: () => context
                                .read<LocationPickerCubit>()
                                .mapController
                                ?.animateCamera(CameraUpdate.zoomIn()),
                            child: const Icon(Icons.add),
                          ),
                          FloatingActionButton.small(
                            heroTag: 'zoom-out',
                            backgroundColor: AppColors.foregroundColor,
                            onPressed: () => context
                                .read<LocationPickerCubit>()
                                .mapController
                                ?.animateCamera(CameraUpdate.zoomOut()),
                            child: const Icon(Icons.remove),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 16,
                      child: FloatingActionButton.small(
                        heroTag: 'my-location',
                        backgroundColor: AppColors.foregroundColor,
                        onPressed: context
                            .read<LocationPickerCubit>()
                            .defineMyLocation,
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
