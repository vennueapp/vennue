part of 'locations_bloc.dart';

enum LocationsStatus { initial, success, failure }

class LocationsState {
  const LocationsState({
    this.status = LocationsStatus.initial,
    this.locations = const <Location>[],
  });

  final LocationsStatus status;
  final List<Location> locations;

  LocationsState copyWith({
    LocationsStatus? status,
    List<Location>? locations,
  }) {
    return LocationsState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
    );
  }
}
