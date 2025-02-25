import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widget/empty placeholder.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  List<Map<String, dynamic>> watchList = [];

  @override
  void initState() {
    super.initState();
    loadWatchList();
  }

  Future<void> loadWatchList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList('watch_list') ?? [];

    setState(() {
      watchList = savedList.map((entry) {
        List<String> parts = entry.split('|');
        return {
          'id': parts[0],
          'poster': parts[1],
          'voteAverage': parts.length > 2 ? double.tryParse(parts[2]) ?? 0.0 : 0.0,
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return watchList.isEmpty
        ? const EmptyPlaceholder()
        : SingleChildScrollView(
          child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
                ),
                itemCount: watchList.length,
                itemBuilder: (context, index) {
          final movie = watchList[index];
          
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
                        "${movie['voteAverage'].toStringAsFixed(1)}",
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
}
