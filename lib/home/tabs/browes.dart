import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc/cubit.dart';
import 'package:movies_app/bloc/state.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int selectedCategory = 0;
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
  void initState() {
    super.initState();
    HomeCubit.get(context).getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8),
              itemCount: moviesCategories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCategory = index;
                    });
                    cubit.getMoviesList(moviesCategories[index]);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: selectedCategory == index
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      moviesCategories[index],
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: selectedCategory == index
                            ? Colors.black
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),

          Expanded(
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is GetMoviesDataLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                if (cubit.moviesList == null || cubit.moviesList!.isEmpty) {
                  return Center(
                    child: Text(
                      "No movies available",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: cubit.moviesList!.length,
                  itemBuilder: (context, index) {
                    final movie = cubit.moviesList![index];

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
                          top: 10,
                          left: 10,
                          child: Container(
                            width: 70,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xB5121312),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}