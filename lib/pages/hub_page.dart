import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vennue/bloc/locations_bloc.dart';

import '../models/location.dart';

class HubPage extends StatelessWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text("Select Hubs"),
        SelectedLocationsList(),
        AvailableLocationsList(),
      ],
    );
  }
}

class SelectedLocationsList extends StatelessWidget {
  const SelectedLocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
      var selectedLocationsList = <Widget>[];
      for (var location in state.selectedLocations) {
        selectedLocationsList
            .add(LocationsTile(location: location, toSelect: false));
      }
      return Column(
        children: [
          const Text("Selected Hubs"),
          ListView(
            shrinkWrap: true,
            children: selectedLocationsList,
          ),
        ],
      );
    });
  }
}

class AvailableLocationsList extends StatelessWidget {
  const AvailableLocationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
      var availableLocationsList = <Widget>[];
      for (var location in state.availableLocations) {
        availableLocationsList
            .add(LocationsTile(location: location, toSelect: true));
      }
      return Column(
        children: [
          const Text("Available Hubs"),
          ListView(
            shrinkWrap: true,
            children: availableLocationsList,
          ),
        ],
      );
    });
  }
}

class LocationsTile extends StatelessWidget {
  const LocationsTile({
    super.key,
    required this.location,
    required this.toSelect,
  });

  final Location location;
  final bool toSelect;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => context.read<LocationsBloc>().add(toSelect
            ? SelectLocation(location: location)
            : DeselectLocation(location: location)),
        child: Text(location.name));
  }
}
