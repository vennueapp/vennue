part of 'locations_bloc.dart';

@immutable
abstract class LocationsEvent {}

class FetchLocations extends LocationsEvent {}

class SelectLocation extends LocationsEvent {
  SelectLocation({required this.location});
  final Location location;
}

class DeselectLocation extends LocationsEvent {
  DeselectLocation({required this.location});
  final Location location;
}
