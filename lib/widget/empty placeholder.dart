import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatefulWidget {
  const EmptyPlaceholder({super.key});

  @override
  State<EmptyPlaceholder> createState() => _EmptyPlaceholderState();
}

class _EmptyPlaceholderState extends State<EmptyPlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset('assets/images/popcorn.png',
        width: 150,
        height: 150,
      ),
    );
  }
}
