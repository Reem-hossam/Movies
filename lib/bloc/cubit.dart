import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../model/details_model.dart';
import '../model/screenshot_model.dart';
import '../model/similar_model.dart';
import '../model/video_model.dart' as video;
import '/bloc/state.dart';

class HomeCubit extends Cubit<HomeStates> {
  MoviesResponse? movieResponse;
  List<MoviesResponse>? moviesList;
  String? movieVideoUrl;
  List<Cast>? movieCast;
  List<Backdrops>? movieScreenshots;
  List<Results> similarMovies = [];


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
        List<dynamic> moviesJson = json['results'];

        // ✅ تحويل القائمة بشكل صحيح
        List<MoviesResponse> movies =
        moviesJson.map((e) => MoviesResponse.fromJson(e)).toList();

        moviesList = movies;  // ✅ تخزين القائمة في متغير جديد

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
          "https://api.themoviedb.org/3/movie/$movieId?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US&append_to_response=credits,videos,images,recommendations&include_image_language=null,en");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        movieResponse = MoviesResponse.fromJson(json);
        movieCast = movieResponse?.cast ?? [];

        movieScreenshots = (json['images']['backdrops'] as List)
            .map((movie) => Backdrops.fromJson(movie))
            .toList();

        similarMovies = (json['recommendations']['results'] as List)
            .map((movie) => Results.fromJson(movie))
            .toList();




        if (json['videos'] != null && json['videos']['results'] != null) {
          var videoList = json['videos']['results'] as List;
          var trailer = videoList.firstWhere(
                (video) => video['type'] == 'Trailer',
            orElse: () => null,
          );
          movieVideoUrl = trailer != null ? trailer['key'] : null;
        } else {
          movieVideoUrl = null;
          print("No videos found!");
        }


        emit(GetMoviesDataSuccessState());
      } else {
        print("Error: API response status code ${response.statusCode}");
        emit(GetMoviesDataErrorState());
      }
    } catch (e) {
      print("Exception: $e");
      emit(GetMoviesDataErrorState());
    }
  }
}
