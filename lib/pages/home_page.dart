import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(title: Text(title)),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => VenuesBloc()..add(FetchVenues()),
          ),
          BlocProvider(
            create: (_) => LocationsBloc()..add(FetchLocations()),
          ),
        ],
        child: const VenuesDisplay(),
      ),
    );
  }
}

class VenuesDisplay extends StatefulWidget {
  const VenuesDisplay({super.key});

  @override
  State<VenuesDisplay> createState() => _VenuesDisplayState();
}

class _VenuesDisplayState extends State<VenuesDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TODO: Make these separate Widgets rather than helper functions
        _locationsSection(),
        _venuesSection(),
      ],
    );
  }
}

_locationsSection() {
  return BlocBuilder<LocationsBloc, LocationsState>(builder: (context, state) {
    // TODO: Maybe move this logic deeper
    switch (state.status) {
      case LocationsStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case LocationsStatus.failure:
        return const Text("Uh Oh, something went wrong");
      case LocationsStatus.success:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose a Location',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              // TODO: Make this actually do something lol... VenueEvent to be sent with FetchVenues
              DropdownButton(
                items: locationsList(state.locations),
                onChanged: ((value) {}),
              ),
            ],
          ),
        );
    }
  });
}

_venuesSection() {
  return BlocBuilder<VenuesBloc, VenuesState>(builder: (context, state) {
    // TODO: Maybe move this logic deeper
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
              for (var venue in state.venues) venueTile(venue),
            ],
          ),
        );
    }
  });
}

List<DropdownMenuItem> locationsList(List<Location> locations) {
  var locationsItems = <DropdownMenuItem>[];
  for (var location in locations) {
    locationsItems.add(DropdownMenuItem(
      value: location.name,
      child: Text(location.name),
    ));
  }
  return locationsItems;
}

Widget venueTile(Venue venue) {
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
