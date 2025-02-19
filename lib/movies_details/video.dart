import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String extractYouTubeVideoId(String url) {
  Uri uri = Uri.parse(url);
  if (uri.queryParameters.containsKey('v')) {
    return uri.queryParameters['v']!;
  } else if (uri.pathSegments.isNotEmpty) {
    return uri.pathSegments.last;
  }
  return '';
}

class YouTubePlayerScreen extends StatefulWidget {
  final String videoUrl;

  const YouTubePlayerScreen({super.key, required this.videoUrl});

  @override
  _YouTubePlayerScreenState createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    print("🔹 Video URL: ${widget.videoUrl}");

    String videoId = extractYouTubeVideoId(widget.videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,

      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
