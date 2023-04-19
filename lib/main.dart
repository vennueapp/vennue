import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Choose a Vennue',
        ),
      ),
    );
  }
}
