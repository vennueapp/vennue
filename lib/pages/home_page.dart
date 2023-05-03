import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vennue/pages/hub_page.dart';

import '../bloc/locations_bloc.dart';
import '../bloc/venues_bloc.dart';
import '../models/location.dart';
import '../models/venue.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          LocationsPicker(),
          VenuesList(),
        ],
      ),
    );
  }
}

class LocationsPicker extends StatelessWidget {
  const LocationsPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
      String locationNames = "";
      for (Location location in state.selectedLocations) {
        locationNames += "${location.name} / ";
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const HubPage(),
                      );
                    }).then((_) {
                  context
                      .read<VenuesBloc>()
                      .add(FetchVenues(locations: state.selectedLocations));
                });
              },
              child: const Text(
                "Hubs",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Text(locationNames),
          ],
        ),
      );
    });
  }
}

class VenuesList extends StatelessWidget {
  const VenuesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenuesBloc, VenuesState>(builder: (context, state) {
      switch (state.status) {
        case VenuesStatus.initial:
          return const Center(child: CircularProgressIndicator());
        case VenuesStatus.failure:
          return const Text("Uh Oh, something went wrong");
        case VenuesStatus.success:
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Choose a Vennue',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                for (var venue in state.venues) VenueTile(venue: venue),
              ],
            ),
          );
      }
    });
  }
}

class VenueTile extends StatelessWidget {
  const VenueTile({super.key, required this.venue});

  final Venue venue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Name: ${venue.name}'),
          Text('Description: ${venue.description}'),
          Text('Location: ${venue.location}'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            // TODO: Investigate image caching
            child: Image.network(
              venue.imagePath,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
