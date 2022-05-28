// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../themes/maintheme.dart';
import '../bloc/argument_models.dart';
import '../routing/route_names.dart';

import 'package:statify/widgets/profile_widgets/headings.dart';
import 'package:statify/widgets/profile_widgets/profile_header.dart';
import 'package:statify/widgets/profile_widgets/top_artists.dart';
import 'package:statify/widgets/profile_widgets/top_tracks.dart';
import 'package:statify/widgets/profile_widgets/cards/analysis_card.dart';
import 'package:statify/widgets/profile_widgets/cards/by_duration_card.dart';
import 'package:statify/widgets/profile_widgets/cards/by_popularity_card.dart';
import 'package:statify/widgets/profile_widgets/cards/by_release_date_card.dart';

/*
  The UserProfile page generates a user's profile based on their listening
  habits.

  The page consists of several metrics analysed from their data, portraying
  their listening style, their top tracks, top artists, and some facts about
  their music.

  There is also a button for the user to get song recommendations. Clicking on
  it takes the user to the SearchScreen Page to search for a song to seed
  the recommendation engine with.
*/

AppTheme currentTheme = AppTheme();

class UserProfile extends StatefulWidget {
  final userProfileData;
  final topArtists;
  final featuresData;
  final topTracks;
  final accessToken;
  final popularityExtremes;
  final durationExtremes;
  final releaseDateExtremes;

  const UserProfile({
    Key? key,
    required this.userProfileData,
    required this.topArtists,
    required this.featuresData,
    required this.topTracks,
    required this.accessToken,
    required this.popularityExtremes,
    required this.durationExtremes,
    required this.releaseDateExtremes,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: widget.userProfileData['display_name'],
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
            height: double.infinity,
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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserHeader(userProfileData: widget.userProfileData),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, searchRoute,
                                arguments: SearchArguments(
                                    accessToken: widget.accessToken));
                          },
                          child: const Text('Get Song Recommendations',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ]),
                  const SizedBox(height: 30),
                  const Heading(title: 'Listening Analysis'),
                  const SizedBox(height: 15),
                  AnalysisCard(featuresData: widget.featuresData),
                  const SizedBox(height: 30),
                  const Heading(title: 'Top Artists'),
                  const SizedBox(height: 15),
                  TopArtists(artistsList: widget.topArtists),
                  const Heading(title: 'Top Tracks'),
                  const SizedBox(height: 15),
                  TopTracks(topTracksData: widget.topTracks),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(title: 'By Popularity'),
                          const SizedBox(height: 25),
                          ByPopularityCard(
                              popularityExtremes: widget.popularityExtremes),
                        ],
                      ),
                      const SizedBox(width: 85),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(title: 'By Duration'),
                          const SizedBox(height: 25),
                          ByDurationCard(
                              durationExtremes: widget.durationExtremes),
                        ],
                      ),
                      const SizedBox(width: 85),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Heading(title: 'By Release Date'),
                          const SizedBox(height: 25),
                          ByReleaseDateCard(
                              releaseDateExtremes: widget.releaseDateExtremes),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
