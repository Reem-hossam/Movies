import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit.dart';
import 'package:movies_app/bloc/state.dart';
import 'package:movies_app/widget/movie_poster.dart';

import '../../widget/poster.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "SourcesSection";
  @override
  Widget build(BuildContext context) {
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
                    // separatorBuilder: (context, index) => SizedBox(width: 16,),
                    itemCount: state.movies.length,
                    scrollDirection: Axis.horizontal,
                  ))
            ],
          );
        } else {
          return Center(child: Text("Error loading movies"));
        }
      },
    );
  }
}
