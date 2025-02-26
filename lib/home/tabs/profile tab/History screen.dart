import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatelessWidget {
  Future<List<Map<String, String>>> getMovieHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> posters = prefs.getStringList('history_posters') ?? [];

    List<Map<String, String>> history = [];
    for (int i = 0; i < posters.length; i++) {
      history.add({
        "poster": posters[i],

      });
    }
    return history;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, String>>>(
        future: getMovieHistory(),
        builder: (context, snapshot) {
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var movie = snapshot.data![index];
               return Stack(
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(10),
                     child: Image.network("https://image.tmdb.org/t/p/w500${movie['poster']}",
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
    );
  }
}
