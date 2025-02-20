import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/theme/app%20theme.dart';
import 'package:movies_app/theme/theme.dart';
import 'bloc/cubit.dart';

import 'home/home.dart';
import 'home/tabs/profile tab/edit profile.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()..getMoviesList()),
      ],
      child:  MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Themes theme = AppTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: Home.routeName,
        theme: theme.themeData,
        routes: {
          UpdateProfileScreen.routeName: (context) => UpdateProfileScreen(),
          Home.routeName: (context) => Home(),
        }
    );
  }
}