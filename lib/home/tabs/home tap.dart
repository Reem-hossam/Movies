import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit.dart';
import 'package:movies_app/bloc/state.dart';
import 'package:movies_app/widget/movie_poster.dart';
import 'package:movies_app/widget/poster.dart';


class HomeTab extends StatefulWidget {
  static const String routeName = "HomeTab";

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    if (cubit.moviesList == null || cubit.moviesList!.isEmpty) {
      cubit.getMoviesList();
    }

    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is GetMoviesDataLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetMoviesListSuccessState) {
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    return MoviePoster(movie: state.movies[index]);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Poster(movie: state.movies[index]);
                  },
                  itemCount: state.movies.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            ],
          );
        } else {
          return Center(child: Text("Error loading movies"));
        }
      },
    );
  }
}

