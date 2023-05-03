import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

import '../models/location.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc() : super(LocationsState()) {
    on<FetchLocations>(_onGetLocations);
    on<SelectLocation>(_onSelectLocation);
    on<DeselectLocation>(_onDeselectLocation);
  }

  _onGetLocations(LocationsEvent event, Emitter<LocationsState> emit) async {
    //final response = await get(Uri.parse('locations.json'));
    final response = await rootBundle.loadString('assets/locations.json');

    //if (response.statusCode == 200) {
    if (response.isNotEmpty) {
      var locationsList = <Location>[];
      //var venuesMap = jsonDecode(response.body);
      var locationsMap = jsonDecode(response);
      for (var location in locationsMap['locations']) {
        locationsList.add(Location.fromMap(location));
      }
      emit(state.copyWith(
          status: LocationsStatus.success, allLocations: locationsList));
    } else {
      emit(state.copyWith(status: LocationsStatus.failure));
      throw Exception('Failed to load locations');
    }
  }

  _onSelectLocation(SelectLocation event, Emitter<LocationsState> emit) {
    var selectedLocations = state.selectedLocations.toList();
    selectedLocations.add(event.location);
    emit(state.copyWith(selectedLocations: selectedLocations));
  }

  _onDeselectLocation(DeselectLocation event, Emitter<LocationsState> emit) {
    var selectedLocations = state.selectedLocations.toList();
    selectedLocations.remove(event.location);
    emit(state.copyWith(selectedLocations: selectedLocations));
  }
}
