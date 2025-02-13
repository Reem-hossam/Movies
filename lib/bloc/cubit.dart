import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../model/details_model.dart';
import '/bloc/state.dart';

class HomeCubit extends Cubit<HomeStates> {
  MoviesResponse? movieResponse;
  String? movieVideoUrl;

  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getMoviesData(int movieId) async {
    try {
      emit(GetMoviesDataLoadingState());
      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print("Movie JSON: $json");
        movieResponse = MoviesResponse.fromJson(json);
        print("Movie Response: $movieResponse");
        await getMovieVideos(movieId);
        emit(GetMoviesDataSuccessState());
      } else {
        print("Error: Failed to load movie details, Status Code: ${response.statusCode}");
        emit(GetMoviesDataErrorState());
      }
    } catch (e) {
      print("Exception while loading movie data: $e");
      emit(GetMoviesDataErrorState());
    }
  }

  Future<void> getMovieVideos(int movieId) async {
    try {
      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/$movieId/videos?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List videos = json['results'];

        var trailer = videos.firstWhere(
              (video) => video['type'] == 'Trailer',
          orElse: () => {},
        );
        if (trailer.isNotEmpty) {
          movieVideoUrl = "https://www.youtube.com/watch?v=${trailer['key']}";
        }
      }
    } catch (e) {
      print("Error fetching videos: $e");
    }
  }
  Future<void> getMoviesList() async {
    try {
      emit(GetMoviesDataLoadingState());
      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US&page=1");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        List moviesJson = json['results'];
        List<MoviesResponse> movies = moviesJson.map((e) => MoviesResponse.fromJson(e)).toList();
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

}
