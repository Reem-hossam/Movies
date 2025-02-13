import '../model/details_model.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class GetMoviesDataLoadingState extends HomeStates {}

class GetMoviesDataSuccessState extends HomeStates {}

class GetMoviesDataErrorState extends HomeStates {}

class GetMoviesListSuccessState extends HomeStates {
  final List<MoviesResponse> movies;
  GetMoviesListSuccessState(this.movies);
}


