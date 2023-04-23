import 'package:flutter/material.dart';

import 'pages/home_page.dart';

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
