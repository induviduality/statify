// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../themes/maintheme.dart';
import '../bloc/api_callers/recommendation_helpers.dart';

import 'song_view.dart';

/*
  This page displays the results of the search made by the user.
  The results of the query are displayed in a scrollable list on this page.
  
  Clicking on a search result will generate song recommendations for the user,
  based on the song clicked on.
*/

AppTheme currentTheme = AppTheme();

class SearchResults extends StatefulWidget {
  final trackList;
  final accessToken;
  const SearchResults({Key? key, required this.trackList, this.accessToken})
      : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statify - Search Results',
      theme: AppTheme.mainTheme,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 10, 12),
        body: Container(
          padding: const EdgeInsets.fromLTRB(150, 20, 150, 20),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: const Text(
                  'Search Results',
                  style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'Click on a song to generate recommendations based on it',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 189, 189, 189))),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.trackList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: Image.network(
                              widget.trackList[index]['coverImage'],
                              width: 50,
                              height: 50),
                          title: Text(
                            widget.trackList[index]['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(widget.trackList[index]['artist'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey[400])),
                          hoverColor: const Color.fromARGB(29, 255, 255, 255),
                          dense: false,
                          visualDensity: VisualDensity.comfortable,
                          onTap: () async {
                            var recommendationsList =
                                await fetchRecommendationsList(
                                    widget.trackList[index]['id']);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SongView(
                                  song: widget.trackList[index],
                                  recommendedTracks: recommendationsList,
                                  accessToken: widget.accessToken,
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
