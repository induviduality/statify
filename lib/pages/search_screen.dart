// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../themes/maintheme.dart';
import '../bloc/api_callers/recommendation_helpers.dart';
import 'search_results.dart';

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: const Color.fromARGB(255, 18, 194, 44),
  minimumSize: const Size(100, 48),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
);

/*
  The SearchScreen page contains a TextField and a button to search for a song.
  Songs will be queried from the Spotify API based on the input given here.
*/

class SearchScreen extends StatefulWidget {
  final accessToken;
  const SearchScreen({Key? key, required this.accessToken}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchBoxController = TextEditingController();
  var trackList = [];

  @override
  void dispose() {
    // Clean up the TextEditingController when the widget is disposed.
    searchBoxController.dispose();
    super.dispose();
  }

  void passQuery(String query, accessToken) async {
    // Pass the query to the API call function.
    // The API call function will return a list of tracks.
    // The list of tracks will be passed to the SearchResults widget.

    var trackList = await fetchSearchResults(query);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SearchResults(trackList: trackList, accessToken: accessToken),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statify - Search',
      theme: AppTheme.mainTheme,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 10, 12),
        body: Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Find me a song like...',
                    style: TextStyle(
                      fontSize: 68,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )),
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                    cursorColor: Colors.white,
                    controller: searchBoxController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 189, 189, 189),
                        fontSize: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      hintText: 'Search for a song',
                    ),
                    onSubmitted: (query) async {
                      passQuery(searchBoxController.text, widget.accessToken);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () async {
                    passQuery(searchBoxController.text, widget.accessToken);
                  },
                  child: const Text('Search',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
