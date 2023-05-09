import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';

import 'package:vennue/models/location.dart';
import 'package:vennue/models/venue.dart';

part 'venues_event.dart';
part 'venues_state.dart';

class VenuesBloc extends Bloc<VenuesEvent, VenuesState> {
  VenuesBloc() : super(const VenuesState()) {
    on<FetchVenues>(_onGetVenues);
  }

  _onGetVenues(FetchVenues event, Emitter<VenuesState> emit) async {
    // TODO: Decide if separate logic for no locations and a location list should go here or be handled by the API
    // Accessible via event.location

    //final response = await get(Uri.parse('venues.json'));
    final response = await rootBundle.loadString('assets/venues.json');

    //if (response.statusCode == 200) {
    if (response.isNotEmpty) {
      var venuesList = <Venue>[];
      //var venuesMap = jsonDecode(response.body);
      var venuesMap = jsonDecode(response);
      for (var venue in venuesMap['venues']) {
        venuesList.add(Venue.fromMap(venue));
      }
      emit(state.copyWith(status: VenuesStatus.success, venues: venuesList));
    } else {
      emit(state.copyWith(status: VenuesStatus.failure));
      throw Exception('Failed to load venues');
    }
  }
}
