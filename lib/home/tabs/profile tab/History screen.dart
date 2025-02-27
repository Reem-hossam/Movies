import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> getMovieHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList('history_posters') ?? [];

    List<Map<String, dynamic>> historyList = [];
    for (String entry in savedList) {
      List<String> parts = entry.split('|');

      if (parts.length == 3) {
        int? id = int.tryParse(parts[0]);
        double? voteAverage = double.tryParse(parts[2]);

        if (id != null && voteAverage != null) {
          historyList.add({
            "id": id,
            "poster": parts[1],
            "voteAverage": voteAverage,
          });
        }
      }
    }

    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getMovieHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading history"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No history available"));
          }

          return SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 18,
                mainAxisSpacing: 18,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];

                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w200${movie['poster']}",
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
                          color: Color(0xB5121312),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${movie['voteAverage']?.toStringAsFixed(1) ?? "0.0"}",
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
        },
      ),
    );
  }
}
