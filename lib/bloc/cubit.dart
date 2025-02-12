import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../model/movie_response.dart';
import '/bloc/state.dart';


class HomeCubit extends Cubit<HomeStates> {
  MoviesResponse? movieResponse;
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(context) => BlocProvider.of(context);


  Future<void> getMoviesData(int movieId) async {
    try {
      emit(GetMoviesDataLoadingState());

      Uri url = Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=6980635866782b3cd72fefe48e1cb0c7&language=en-US");
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        movieResponse = MoviesResponse.fromJson(json);
        emit(GetMoviesDataSuccessState());
      } else {
        emit(GetMoviesDataErrorState());
      }
    } catch (e) {
      emit(GetMoviesDataErrorState());
    }
  }

}