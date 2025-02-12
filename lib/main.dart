import 'package:flutter/material.dart';
import 'movies_details/movies_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: MoviesDetails.routeName,
        routes: {
        MoviesDetails.routeName: (context) =>  MoviesDetails(movieId: 711),
        }
    );
  }
}
