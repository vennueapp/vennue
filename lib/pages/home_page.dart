import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/venues_bloc.dart';
import '../models/venue.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider(
        create: (_) => VenuesBloc()..add(FetchVenues()),
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
