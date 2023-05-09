part of 'locations_bloc.dart';

enum LocationsStatus { initial, success, failure }

class LocationsState {
  LocationsState({
    this.status = LocationsStatus.initial,
    this.allLocations = const <Location>[],
    this.selectedLocations = const <Location>[],
  }) {
    availableLocations = allLocations
        .where((location) => !selectedLocations.contains(location))
        .toList();
  }

  final LocationsStatus status;
  final List<Location> allLocations;
  List<Location> selectedLocations;
  late List<Location> availableLocations;

  LocationsState copyWith({
    LocationsStatus? status,
    List<Location>? allLocations,
    List<Location>? selectedLocations,
  }) {
    return LocationsState(
      status: status ?? this.status,
      allLocations: allLocations ?? this.allLocations,
      selectedLocations: selectedLocations ?? this.selectedLocations,
    );
  }
}
