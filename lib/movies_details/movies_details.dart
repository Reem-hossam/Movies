import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';

class MoviesDetails extends StatefulWidget {
  final int movieId;
  const MoviesDetails({Key? key, required this.movieId}) : super(key: key);
  static const String routeName = "MoviesDetails";

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeCubit>().getMoviesData(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          if (state is GetMoviesDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMoviesDataSuccessState) {
            var movie = HomeCubit.get(context).movieResponse;
            if (movie == null) {
              return const Center(child: Text("Movie data is null", style: TextStyle(color: Colors.white)));
            }
            return buildMovieDetails(context, movie);
          } else {
            return const Center(
              child: Text("Error loading movie", style: TextStyle(color: Colors.white)),
            );
          }
        },
      ),
    );
  }

  Widget buildMovieDetails(BuildContext context, dynamic movie) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                movie.backdropPath != null
                    ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}"
                    : "https://via.placeholder.com/500x750",
                fit: BoxFit.fill,
                width: double.infinity,
                height: 500,
              ),
              Positioned(
                top: 270,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      movie.title ?? "Unknown Title",
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      movie.releaseDate?.split('-')[0] ?? "Unknown Year",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildInfoContainer(Icons.favorite, "${(movie.voteAverage * 10).toStringAsFixed(0)}%"),
                    buildInfoContainer(Icons.access_time_filled, "${movie.runtime ?? "0"} min"),
                    buildInfoContainer(Icons.star, "${movie.voteAverage?.toStringAsFixed(1) ?? "0.0"}"),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Watch", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 10),
                buildSection("Screen Shots"),
                buildSection("Similar"),
                buildSection("Summary"),
                Text(
                  movie.overview ?? "No overview available.",
                  style: const TextStyle(color: Colors.white70),
                ),
                buildSection("Cast"),
                buildSection("Genres"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoContainer(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff282A28),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.yellow),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
