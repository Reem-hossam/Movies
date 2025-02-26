import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/details_model.dart';
import '../movies_details/movies_details.dart';

class MoviePoster extends StatelessWidget {
  final MoviesResponse movie;
  static const String routeName = "poster";
  const MoviePoster({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
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
          child:
             Stack(alignment: Alignment.center,
                    children: [

                  Image.network(
                    "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height*0.6,

                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(1), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                    ),
                  ),),
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl:
                          "https://image.tmdb.org/t/p/w200${movie.posterPath}",

                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ))
                ]),


          ),
        );
  }
}
