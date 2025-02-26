import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/model/details_model.dart';

import '../bloc/cubit.dart';
import '../movies_details/movies_details.dart';
class Poster extends StatelessWidget {
  final MoviesResponse movie;
  static const String routeName = "poster";

   Poster({required this.movie,super.key});
  List<String> moviesCategories = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Sci-Fi",
    "Horror",
    "Fantasy",
    "Romance",
    "Comedy"
  ];


  @override
  Widget build(BuildContext context) {
    return   Material(
        color: Colors.transparent,
        child: InkWell(
        onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviesDetails(movieId: movie.id!),
        ),
      );
    },
    child:Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:  CachedNetworkImage(
              imageUrl:
              "https://image.tmdb.org/t/p/w200${movie.posterPath}",
              fit: BoxFit.fill,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ),
          ),
    )));
  }}
