import 'package:flutter/material.dart';

import '../../../widget/empty placeholder.dart';

class WatchList extends StatelessWidget {
  final List<String> movies = [];

  @override
  Widget build(BuildContext context) {
    return movies.isEmpty
        ? const EmptyPlaceholder()
        : ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index]),
        );
      },
    );
  }
}
