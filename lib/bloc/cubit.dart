import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../model/details_model.dart';
import '../model/similar_model.dart';
import '/bloc/state.dart';

class HomeCubit extends Cubit<HomeStates> {
  MoviesResponse? movieResponse;
  String? movieVideoUrl;
  List<Cast>? movieCast;
  List<String>? movieScreenshots;
  List<Results>? similarMovies;

  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getMoviesList() async {
    try {
      emit(GetMoviesDataLoadingState());
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US&page=1");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List moviesJson = json['results'];
        List<MoviesResponse> movies =
        moviesJson.map((e) => MoviesResponse.fromJson(e)).toList();
        emit(GetMoviesListSuccessState(movies));
      } else {
        print("Error: Failed to load movies list, Status Code: ${response.statusCode}");
        emit(GetMoviesDataErrorState());
      }
    } catch (e) {
      print("Exception while loading movies list: $e");
      emit(GetMoviesDataErrorState());
    }
  }


  Future<void> getMoviesData(int movieId) async {
    try {
      emit(GetMoviesDataLoadingState());
      Uri url = Uri.parse(
          "https://api.themoviedb.org/3/movie/$movieId?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US&append_to_response=credits,videos,images,recommendations");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        movieResponse = MoviesResponse.fromJson(json);
        movieCast = movieResponse?.cast ?? [];
        movieScreenshots = movieResponse?.screenshots ?? [];
        similarMovies = (json['recommendations']['results'] as List)
            .map((movie) => Results.fromJson(movie))
            .toList();

        movieVideoUrl = json['videos']['results'].firstWhere(
              (video) => video['type'] == 'Trailer',
          orElse: () => {},
        )['key'];

        emit(GetMoviesDataSuccessState());
      } else {
        emit(GetMoviesDataErrorState());
      }
    } catch (e) {
      emit(GetMoviesDataErrorState());
    }
  }
}