part of 'location_picker_cubit.dart';

sealed class LocationPickerState extends Equatable {
  const LocationPickerState();

  @override
  List<Object> get props => [];
}

final class LocationPickerInitial extends LocationPickerState {}

final class LocationPickerLocationUpdated extends LocationPickerState {
  final LatLng latLng;
  final Set<Marker> markers;
  final geo.Placemark? placemark;

  const LocationPickerLocationUpdated({
    required this.latLng,
    this.placemark,
    this.markers = const {},
  });

  @override
  List<Object> get props => [latLng, markers, placemark ?? geo.Placemark];
}
