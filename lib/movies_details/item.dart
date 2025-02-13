
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/details_model.dart';
import 'movies_details.dart';

class NewsItem extends StatelessWidget {
  final MoviesResponse movie;

  const NewsItem({required this.movie, super.key});

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
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: "https://image.tmdb.org/t/p/w500${movie.backdropPath}",
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Text(
                    movie.title ?? "Movie Title",
                    style: const TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(movie.releaseDate ?? "Unknown Date",
                          style: const TextStyle(color: Colors.white)),
                      Text(
                          "Rating: ${movie.voteAverage?.toStringAsFixed(1) ?? 'N/A'}",
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
