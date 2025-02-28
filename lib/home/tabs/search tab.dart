import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit.dart';
import 'package:movies_app/model/details_model.dart';


class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List<MoviesResponse> filteredMovies = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      filterMovies();
    });
  }

  void filterMovies() {
    final query = searchController.text.toLowerCase();
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    if (homeCubit.moviesList != null) {
      setState(() {
        isSearching = query.isNotEmpty;
        filteredMovies = homeCubit.moviesList!
            .where((movie) => movie.title!.toLowerCase().contains(query))
            .toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff121312),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 55,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xff282A28),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 4, horizontal: 15),
                  prefixIcon: Icon(Icons.search, color: Colors.white, size: 24),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

            Expanded(
              child: isSearching && filteredMovies.isNotEmpty
                  ? GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                ),
                itemCount: filteredMovies.length,
                itemBuilder: (context, index) {
                  final movie = filteredMovies[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w200${movie.posterPath}",
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xB5121312),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "${movie.voteAverage?.toStringAsFixed(1) ??
                                    "0.0"}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                  Icons.star, color: Colors.yellow, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
                  : Center(
                child: Image.asset("assets/images/popcorn.png"),
              ),
            ),
          ],
        ));


  }}