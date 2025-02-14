import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import '../model/details_model.dart';
import '../model/similar_model.dart';

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
            var similarMovies = HomeCubit.get(context).similarMovies;
            if (movie == null) {
              return const Center(
                  child: Text("Movie data is null", style: TextStyle(color: Colors.white)));
            }
            return buildMovieDetails(context, movie, similarMovies ?? []);
          } else {
            return const Center(
              child: Text("Error loading movie", style: TextStyle(color: Colors.white)),
            );
          }
        },
      ),
    );
  }

  Widget buildMovieDetails(BuildContext context, dynamic movie, List<Results> similarMovies) {
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
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(6),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text("Watch", style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
                buildSection("Screen Shots"),
                buildScreenshots(movie.screenshots),
                buildSection("Similar"),
                buildSimilarMovies(similarMovies ?? []),
                buildSection("Summary"),
                Text(
                  movie.overview ?? "No overview available.",
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                buildSection("Cast"),
                buildCastList(movie.cast),
                buildSection("Genres"),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: movie.genres.map<Widget>((genre) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xff282A28),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        genre.name, // Display individual genre name instead of joining all
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(), // Convert to List<Widget>
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSimilarMovies(List<Results> similarMovies) {
    if (similarMovies.isEmpty) {
      return Center(
        child: Text("No Similar Movies Available", style: TextStyle(color: Colors.white70)),
      );
    }

    final displayedMovies = similarMovies
        .where((movie) => movie.backdropPath != null)
        .take(4)
        .toList();

    if (displayedMovies.isEmpty) {
      return Center(
        child: Text("No Similar Movies Available", style: TextStyle(color: Colors.white70)),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
      ),
      itemCount: displayedMovies.length,
      itemBuilder: (context, index) {
        final movie = displayedMovies[index];

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://image.tmdb.org/t/p/w200${movie.backdropPath}",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Container(
                width: 70,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xB5121312),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Text(
                      "${movie.voteAverage?.toStringAsFixed(1) ?? "0.0"}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  Widget buildScreenshots(List<String>? screenshots) {
    if (screenshots == null || screenshots.isEmpty) {
      return Center(
        child: Text("No Screenshots Available", style: TextStyle(color: Colors.white70)),
      );
    }
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                screenshots[index],
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
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

  Widget buildCastList(List<Cast> castList) {
    if (castList.isEmpty) {
      return Center(
        child: Text("No Cast Available", style: TextStyle(color: Colors.white70)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            final cast = castList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff282A28),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        cast.profilePath != null
                            ? 'https://image.tmdb.org/t/p/w200${cast.profilePath}'
                            : 'https://via.placeholder.com/60',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name : ${cast.name ?? "Unknown"}",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Character : ${cast.character ?? ""}",
                              style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildSection(String title) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
