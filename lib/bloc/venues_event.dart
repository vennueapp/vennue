part of 'venues_bloc.dart';

@immutable
abstract class VenuesEvent {}

class FetchVenues extends VenuesEvent {
  FetchVenues({this.locations = const <Location>[]});
  final List<Location> locations;
}
