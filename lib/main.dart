import 'package:flutter/material.dart';

import 'models/venue.dart';

void main() {
  runApp(const Vennue());
}

class Vennue extends StatelessWidget {
  const Vennue({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vennue',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(title: 'Vennue'),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  final venues = const {
    Venue(
      "James",
      "He's James",
      "James' House",
      "https://avatars.githubusercontent.com/u/49141566?v=4",
    ),
    Venue(
      "Alec",
      "He's Alec",
      "Alec's House",
      "https://avatars.githubusercontent.com/u/27219575?v=4",
    ),
    Venue(
      "Sean",
      "He's Sean",
      "Sean's House",
      "https://avatars.githubusercontent.com/u/44223556?v=4",
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a Vennue',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            for (var venue in venues) venueTile(venue),
          ],
        ),
      ),
    );
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
