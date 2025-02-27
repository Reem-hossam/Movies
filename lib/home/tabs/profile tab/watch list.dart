import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../widget/empty placeholder.dart';

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  List<Map<String, String>> watchedMovies = [];

  @override
  void initState() {
    super.initState();
    loadWatchedMovies();
  }

  void loadWatchedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> watchList = prefs.getStringList('watch_list') ?? [];

    setState(() {
      watchedMovies = watchList.map((movie) {
        var parts = movie.split('|');
        return {
          'id': parts[0],
          'posterPath': parts[1],
          'voteAverage': parts[2],
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: watchedMovies.isEmpty
          ? const EmptyPlaceholder()
          : buildWatchedMovies(watchedMovies),
    );
  }
}

Widget buildWatchedMovies(List<Map<String, String>> watchList) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: watchList.length,
      itemBuilder: (context, index) {
        final movie = watchList[index];

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie['posterPath']!.isNotEmpty
                    ? "https://image.tmdb.org/t/p/w200${movie['posterPath']}"
                    : "https://via.placeholder.com/200",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${movie['voteAverage'] ?? "0.0"}",
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
    ),
  );
}
