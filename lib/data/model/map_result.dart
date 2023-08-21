import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsResult extends Equatable {
  final Placemark? placemark;
  final LatLng? latLng;

  const MapsResult({required this.placemark, required this.latLng});

  @override
  List<Object?> get props => [placemark, latLng];
}
