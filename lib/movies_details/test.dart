import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cubit.dart';
import '../bloc/state.dart';
import 'item.dart';

class SourcesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is GetMoviesDataLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetMoviesListSuccessState) {
          return ListView.builder(
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return NewsItem(movie: state.movies[index]);
            },
          );
        } else {
          return Center(child: Text("Error loading movies"));
        }
      },
    );
  }
}
