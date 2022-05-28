// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../themes/maintheme.dart';
import '../bloc/api_callers/user_data_helpers.dart';
import '../widgets/song_view_widgets/recommendations_list.dart';
import '../widgets/song_view_widgets/song_header.dart';

/*
  Displays the song selected from the search results on a larger view, 
  followed by a list of song recommendations based on that song.
*/

AppTheme currentTheme = AppTheme();

class SongView extends StatefulWidget {
  final song;
  final recommendedTracks;
  final accessToken;
  const SongView(
      {Key? key,
      required this.song,
      required this.recommendedTracks,
      this.accessToken})
      : super(key: key);

  @override
  State<SongView> createState() => _SongViewState();
}

class _SongViewState extends State<SongView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song View',
      theme: AppTheme.mainTheme,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: const Color.fromARGB(255, 9, 10, 12),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.45],
              colors: [
                Color.fromARGB(255, 16, 175, 87),
                Colors.transparent,
              ],
            ),
          ),
          child: Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(150, 75, 150, 50),
              controller: _scrollController,
              children: [
                SongHeader(song: widget.song),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 15, 0, 15),
                      child: Text('Songs like ${widget.song['name']}',
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    const SizedBox(width: 30.0),
                    ElevatedButton.icon(
                      onPressed: () async {
                        var saveStatus = await saveTracksAsPlaylist(
                            widget.accessToken, widget.recommendedTracks);
                        if (saveStatus) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 20, 23, 28),
                              title: const Text('Playlist created!'),
                              content:
                                  const Text('Playlist created successfully!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 20, 23, 28),
                              title: const Text('Playlist creation failed'),
                              content: const Text('API could not find songs like this one.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 40, 40, 40)),
                        maximumSize: MaterialStateProperty.all<Size>(
                            const Size(200, 80)),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                      ),
                      icon: const Icon(
                        Icons.queue_music_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      label: const Text('Save as playlist',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                RecommendedTracks(recommendedTracks: widget.recommendedTracks),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
