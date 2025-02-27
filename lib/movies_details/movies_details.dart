import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/movies_details/video.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../bloc/cubit.dart';
import '../bloc/state.dart';
import '../home/home.dart';
import '../model/details_model.dart';
import '../model/screenshot_model.dart';
import '../model/similar_model.dart' ;
import '../model/video_model.dart' as video;


class MoviesDetails extends StatefulWidget {
  final int movieId;
  const MoviesDetails({Key? key, required this.movieId}) : super(key: key);
  static const String routeName = "MoviesDetails";

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  bool isPlaying = false;
  late YoutubePlayerController _youtubeController;
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<HomeCubit>().getMoviesData(widget.movieId);
      var movie = HomeCubit.get(context).movieResponse;
      if (movie != null) {
        addToHistory(widget.movieId, movie.posterPath ?? "", movie.voteAverage ?? 0.0);
      }
    });
  }

  void addToWatchList(int movieId, String posterPath, double voteAverage) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchList = prefs.getStringList('watch_list') ?? [];

    String movieData = '$movieId|$posterPath|$voteAverage';

    if (!watchList.contains(movieData)) {
      watchList.add(movieData);
      await prefs.setStringList('watch_list', watchList);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
        }, icon:Icon(Icons.arrow_back_ios_new,
        color: Colors.white,),
      ),
        actions: [
          BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              if (state is GetMoviesDataSuccessState) {
                return GestureDetector(
                  onTap: ()  {
                    var movie = HomeCubit.get(context).movieResponse;
                    if (movie != null) {
                       addToWatchList(widget.movieId, movie.posterPath ?? "", movie.voteAverage ?? 0.0);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Added to Watch List!")),
                      );
                    }
                  },

                  child: Image.asset(
                    "assets/images/save.png",
                    width: 30,
                    height: 30,
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],


      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          if (state is GetMoviesDataLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMoviesDataSuccessState) {
            var cubit = HomeCubit.get(context);
            var movie = cubit.movieResponse;
            var similarMovies = cubit.similarMovies ?? <Results>[];
            var screenshots = cubit.movieScreenshots ?? <Backdrops>[];

            if (movie == null) {
              return const Center(
                child: Text("Movie data is null", style: TextStyle(color: Colors.white)),
              );
            }
            return buildMovieDetails(context, movie, similarMovies, screenshots);
          } else {
            return const Center(
              child: Text("Error loading movie", style: TextStyle(color: Colors.white)),
            );
          }
        },
      ),
    );

  }

  Widget buildMovieDetails(BuildContext context, dynamic movie, List<Results> similarMovies, List<Backdrops> screenshots) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              isPlaying
                  ? YoutubePlayer(
                controller: _youtubeController,
                showVideoProgressIndicator: true,

              )
                  : Image.network(
                movie.backdropPath != null
                    ? "https://image.tmdb.org/t/p/w500${movie.backdropPath}"
                    : "https://via.placeholder.com/500x750",
                fit: BoxFit.fill,
                width: double.infinity,
                height: 500,
              ),
              if (!isPlaying)
                GestureDetector(
                  onTap: () {
                    String? trailerUrl = HomeCubit.get(context).movieVideoUrl;
                    if (trailerUrl != null) {
                      String videoId = extractYouTubeVideoId(trailerUrl);

                      setState(() {
                        _youtubeController = YoutubePlayerController(
                          initialVideoId: videoId,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: false,
                          ),
                        );
                        isPlaying = true;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No trailer available")),
                      );
                    }
                  },
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
                    onPressed: () {
                        String? trailerUrl = HomeCubit.get(context).movieVideoUrl;
                        if (trailerUrl != null) {
                          String videoId = extractYouTubeVideoId(trailerUrl);

                          setState(() {
                            _youtubeController = YoutubePlayerController(
                              initialVideoId: videoId,
                              flags: const YoutubePlayerFlags(
                                autoPlay: true,
                                mute: false,
                              ),
                            );
                            isPlaying = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("No trailer available")),
                          );
                        }
                        },
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
                buildScreenshots(screenshots?? []),
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
                buildCastList(movie.cast ?? []),
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
                        genre.name,
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

  Widget buildScreenshots(List<Backdrops> screenshots) {
    if (screenshots.isEmpty) {
      return Center(
        child: Text(
          "No Screenshots Available",
          style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: screenshots.length.clamp(0, 3),
          itemBuilder: (context, index) {
            final backdrop = screenshots[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://image.tmdb.org/t/p/w500${backdrop.filePath}",
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[800],
                      child: Center(child: Icon(Icons.broken_image, color: Colors.white70)),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
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


Future<void> addToHistory(int movieId, String posterPath, double voteAverage) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> savedList = prefs.getStringList('history_posters') ?? [];

  String entry = '$movieId|$posterPath|$voteAverage';

  if (!savedList.contains(entry)) {
    savedList.add(entry);
    await prefs.setStringList('history_posters', savedList);
    print("Movie added to history: $entry");
  }
}



