import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vennue/bloc/locations_bloc.dart';

import '../models/location.dart';

//TODO: Investigate state preservation once closing modal bottom sheet
class HubPage extends StatelessWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationsBloc()..add(FetchLocations()),
      child: const LocationsPicker(),
    );
  }
}

class LocationsPicker extends StatefulWidget {
  const LocationsPicker({super.key});

  @override
  State<LocationsPicker> createState() => _LocationsPickerState();
}

class _LocationsPickerState extends State<LocationsPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsState>(
        builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          title(),
          locationTextEntry(),
          // TODO: Neaten these two up fr fr
          selectedLocations(context, state),
          availableLocations(context, state),
        ],
      );
    });
  }
}

title() {
  return const Text("Select Hubs");
}

locationTextEntry() {
  return const TextField(
    decoration: InputDecoration(label: Text("Search for Hubs")),
  );
}

selectedLocations(BuildContext context, LocationsState state) {
  var selectedLocationsList = <Widget>[];
  state.selectedLocations.forEach((element) {
    selectedLocationsList.add(locationsTile(context, element, false));
  });
  return Column(
    children: [
      const Text("Selected Hubs"),
      ListView(
        shrinkWrap: true,
        children: selectedLocationsList,
      ),
    ],
  );
}

availableLocations(BuildContext context, LocationsState state) {
  var availableLocationsList = <Widget>[];
  state.availableLocations.forEach((element) {
    availableLocationsList.add(locationsTile(context, element, true));
  });
  return Column(
    children: [
      const Text("Available Hubs"),
      ListView(
        shrinkWrap: true,
        children: availableLocationsList,
      ),
    ],
  );
}

// TODO: Consider named toSelect option maybe? Might not be issue with separate widgets
locationsTile(BuildContext context, Location location, bool toSelect) {
  return TextButton(
      onPressed: () => context.read<LocationsBloc>().add(toSelect
          ? SelectLocation(location: location)
          : DeselectLocation(location: location)),
      child: Text(location.name));
}
