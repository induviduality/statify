import 'package:flutter/material.dart';

import '../themes/maintheme.dart';
import '../../routing/route_names.dart';
import '../bloc/argument_models.dart';
import '../bloc/auth.dart';
import '../bloc/api_callers/user_data_helpers.dart';

/*
  Intermediate page for the authentication process.
  
  This page works with the redirect_uri page to manually pass the 
  authorization code and other data for the profile page.
  
  This is done due to the limitations in Flutter for Web platforms.
  What limitation?
    - There is no reliable way to receive callback from the redirect_uri
      automatically on the Web platform.
    - Even if we leverage the redirect page to send a callback, the 
      callback is not received because listening to callbacks (or) 
      link streams is not implemented in Flutter Web yet.
*/

AppTheme currentTheme = AppTheme();

class AuthIntermediatory extends StatefulWidget {
  final String authorizationCode;
  const AuthIntermediatory({Key? key, required this.authorizationCode})
      : super(key: key);

  @override
  State<AuthIntermediatory> createState() => _AuthIntermediatoryState();
}

class _AuthIntermediatoryState extends State<AuthIntermediatory> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.mainTheme,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
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
              children: [
                const Text('Almost there!',
                    style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                const SizedBox(height: 50),
                ElevatedButton(
                  child: const Text('Take me to my profile!',
                      style:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
                  onPressed: () async {
                    var accessToken =
                        await getUserAccessToken(widget.authorizationCode);
                    var userProfileData = await getUserProfile(accessToken);
                    var topArtists =
                        await getTopXNames(accessToken, 'artists', 10);
                    var recentlyPlayed =
                        await getRecentlyPlayedTrackIDs(accessToken);
                    var featuresData =
                        await getListeningAnalysis(accessToken, recentlyPlayed);
                    var topTracks = await getTopX(accessToken, 'tracks', 10);
                    topTracks = getTracksNameArtistsIDs(topTracks);
                    
                    var popularityExtremes =
                        await getMostAndLeastPopularTracks(accessToken);
                    var durationExtremes =
                        await getLongestAndShortest(accessToken);
                    var releaseDateExtremes =
                        await getEarliestAndLatest(accessToken);

                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, userProfileRoute,
                        arguments: UserProfileArguments(
                            userProfileData: userProfileData,
                            topArtists: topArtists,
                            featuresData: featuresData,
                            topTracks: topTracks,
                            accessToken: accessToken,
                            popularityExtremes: popularityExtremes,
                            durationExtremes: durationExtremes,
                            releaseDateExtremes: releaseDateExtremes
                          )
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
