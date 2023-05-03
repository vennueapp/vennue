import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/locations_bloc.dart';
import 'bloc/venues_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const Vennue());
}

class Vennue extends StatelessWidget {
  const Vennue({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => VenuesBloc()..add(FetchVenues()),
        ),
        BlocProvider(
          create: (_) => LocationsBloc()..add(FetchLocations()),
        ),
      ],
      child: MaterialApp(
        title: 'Vennue',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFFF9BD37, colour),
          scaffoldBackgroundColor: const Color(0xFF1E1B16),
          dialogBackgroundColor: const Color(0xFF1E1B16),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Color(0xFF1E1B16),
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xFFF6E0BB),
                displayColor: const Color(0xFFF6E0BB),
              ),
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(title: 'Vennue'),
      ),
    );
  }
}

Map<int, Color> colour = {
  50: const Color.fromRGBO(249, 189, 55, .1),
  100: const Color.fromRGBO(249, 189, 55, .2),
  200: const Color.fromRGBO(249, 189, 55, .3),
  300: const Color.fromRGBO(249, 189, 55, .4),
  400: const Color.fromRGBO(249, 189, 55, .5),
  500: const Color.fromRGBO(249, 189, 55, .6),
  600: const Color.fromRGBO(249, 189, 55, .7),
  700: const Color.fromRGBO(249, 189, 55, .8),
  800: const Color.fromRGBO(249, 189, 55, .9),
  900: const Color.fromRGBO(249, 189, 55, 1),
};
