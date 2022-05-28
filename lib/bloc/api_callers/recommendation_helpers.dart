import 'dart:convert';
import 'package:http/http.dart';

import '../auth.dart';

/*
  This file contains all the helper functions that make API calls to Spotify
  to generate Song Recommendations.

  The functions perform the following functions:
      - Search for a song
      - Fetch Search Results
      - Generate Recommendations from a song
  
  These functions do not need user authentication and not specific 
  to the user's listening habits.
*/

Future searchSpotify(String query) async {
  // Search Spotify for a track
  // Returns a list of tracks as response
  // Each track is a map containing its data

  var accessToken = await getClientAccessToken();
  var encodedQuery = Uri.encodeQueryComponent(query);
  var client = Client();
  var url = 'https://api.spotify.com/v1/search?q=$encodedQuery&type=track';
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });
  return response.body;
}

Future fetchSearchResults(String query) async {
  // Fetch the search results from the Spotify API and return a list of tracks.
  // The list of tracks will be used to populate the list of songs in the
  // search results.

  var responseBody = await searchSpotify(query);
  var responseJson = json.decode(responseBody);
  var tracks = responseJson['tracks']['items'];

  // Extract name, artist, and album from each track
  tracks = tracks.map((track) {
    return {
      'name': track['name'],
      'artist': track['artists'][0]['name'],
      'coverImage': track['album']['images'][0]['url'],
      'id': track['id'],
    };
  }).toList();

  return tracks;
}

Future getRecommendationsFromSong(String seedSongID) async {
  // Makes a request to the Spotify API to get
  // recommendations based on the given seed song.
  // Returns a list of tracks as response
  // Each track is a map containing its data

  var accessToken = await getClientAccessToken();
  var client = Client();
  var url =
      'https://api.spotify.com/v1/recommendations?seed_tracks=$seedSongID&limit=40';
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });
  return response.body;
}

Future fetchRecommendationsList(String seedSongID) async {
  // Fetches recommendations from the Spotify API by seeding a song.
  // The seed song will be used to get recommendations for the user.
  // Returns a list of tracks as response
  // Each track is a map containing its data

  var responseBody = await getRecommendationsFromSong(seedSongID);
  var responseJson = json.decode(responseBody);

  // Extract some of the data from the response
  var tracks = responseJson['tracks'];
  var trackList = tracks.map((track) {
    return {
      'name': track['name'],
      'artist': track['artists'][0]['name'],
      'album': track['album']['name'],
      'coverImage': track['album']['images'][0]['url'],
      'id': track['id'],
      'link': track['external_urls']['spotify'],
    };
  }).toList();

  return trackList;
}
