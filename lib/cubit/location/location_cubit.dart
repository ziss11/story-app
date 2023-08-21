import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getPlacemarkFromLatLng(LatLng latLng, languageCode) async {
    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
      localeIdentifier: languageCode,
    );

    final place = info[0];

    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    final marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    emit(LocationSuccess(markers: {marker}, placemark: place));
  }

  void defineMarker(LatLng latLng, geo.Placemark place) {
    final street = place.street;
    final address =
        '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    final marker = Marker(
      markerId: const MarkerId('source'),
      position: latLng,
      infoWindow: InfoWindow(
        title: street,
        snippet: address,
      ),
    );

    emit(LocationUpdated(
      latLng: latLng,
      markers: {marker},
      placemark: place,
    ));
  }

  Future<void> defineMyLocation() async {
    final location = Location();

    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        debugPrint('Location service is not available');
        return;
      }
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        debugPrint('Location permission is denied');
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    setLocation(latLng);
  }

  void setLocation(LatLng latLng) async {
    final info = await geo.placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    final place = info[0];

    defineMarker(latLng, place);

    mapController?.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
