import 'package:flutter/material.dart';
import 'package:movies_app/widget/empty%20placeholder.dart';

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  final List<String> movies = [];

  @override
  Widget build(BuildContext context) {
     return   movies.isEmpty
        ? const EmptyPlaceholder()
        : GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
          ],
        );
      },
    );
  }
}
