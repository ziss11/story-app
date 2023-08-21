part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationSuccess extends LocationState {
  final Set<Marker> markers;
  final geo.Placemark? placemark;

  const LocationSuccess({
    this.placemark,
    this.markers = const {},
  });

  @override
  List<Object> get props => [markers, placemark ?? geo.Placemark];
}

final class LocationUpdated extends LocationState {
  final LatLng latLng;
  final Set<Marker> markers;
  final geo.Placemark? placemark;

  const LocationUpdated({
    required this.latLng,
    this.placemark,
    this.markers = const {},
  });

  @override
  List<Object> get props => [latLng, markers, placemark ?? geo.Placemark];
}
