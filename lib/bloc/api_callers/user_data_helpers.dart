// ignore_for_file: unnecessary_cast
import 'package:http/http.dart';
import 'dart:convert';

/*
  This file contains all the helper functions that are necessary
  to generate the User's profile and their listening analysis.

  Some additional helper functions to support these functions are 
  found in the first part of this file too.

  The functions here perform the following functions:
      - Search for a song
      - Fetch Search Results
      - Generate Recommendations from a song
  
  The functions in this file require user authentication 
  in order to perform their tasks.
*/

// -------- Non-API Call Functions --------

standardizeDate(date) {
  // Standardize the date format to YYYY-MM-DD
  // This is needed as certain dates are returned as
  // YYYY or YYYY-MM, which makes comparison difficult.

  if (date.length == 4) {
    return date + '-01-01';
  } else if (date.length == 7) {
    return date + '-01';
  } else {
    return date;
  }
}

bool dateCompare(dateA, dateB) {
  // Compare two dates and return true if dateA is before dateB
  dateA = standardizeDate(dateA);
  dateB = standardizeDate(dateB);
  var dateTimeA = DateTime.parse(dateA);
  var dateTimeB = DateTime.parse(dateB);
  return dateTimeA.isBefore(dateTimeB);
}

String getCommaSeparatedString(items) {
  // Takes a list of items and returns a comma separated string.
  // Used to get a comma separated string of track IDs.
  return items.join(',');
}

double getAverageX(audioFeatures, feature) {
  // Get the average of a given feature across all tracks.
  // Used to get the average danceability, energy, etc.

  var featureList = audioFeatures.map((item) {
    return item[feature];
  }).toList();
  return featureList.reduce((a, b) => a + b) / featureList.length;
}

getTracksNameArtistsIDs(tracksData) {
  // tracksData is a list of tracks
  // each track is a map
  var tracksNameArtistsIDs = [];
  for (var track in tracksData) {
    var trackName = track['name'];
    var artists = track['artists'][0]['name'];
    var trackID = track['id'];
    tracksNameArtistsIDs.add([trackName, artists, trackID]);
  }
  return tracksNameArtistsIDs;
}

// -------- API Call Functions  --------

Future getUserProfile(accessToken) async {
  // Get the user's profile from the Spotify API.
  // Returns a map containing the user's profile data.

  var url = 'https://api.spotify.com/v1/me';
  var response = await get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });
  return json.decode(response.body);
}

Future getTopXNames(accessToken, type,
    [number = 20, timeRange = 'medium_term']) async {
  // Get the names of the top X of the user
  // X can be 'artists' or 'tracks'
  // Hence, if type is 'artists', get the top 20 artists
  // If type is 'tracks', get the top 20 tracks
  // Returns a list of strings containing the names of the top X 

  var items = await getTopX(accessToken, type, number, timeRange);
  return items.map((item) => item['name']).toList();
}

Future getTopX(accessToken, type, [number = 20, timeRange = 'medium_term']) async {
  // Gets the user's top 'number' number of artists or tracks.
  // The 'type' parameter should be either 'artists' or 'tracks'.

  var url =
      'https://api.spotify.com/v1/me/top/$type?limit=$number&time_range=$timeRange';

  // Checking if the time range parameter is valid before making the request.
  // If the time range is not valid, the request will be made
  // with the default time range.
  var timeRanges = ['short_term', 'medium_term', 'long_term'];
  if (!timeRanges.contains(timeRange)) {
    url = 'https://api.spotify.com/v1/me/top/$type?limit=$number';
  }

  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  // return names and IDs
  return json.decode(response.body)['items'];
}

Future getRecentlyPlayedTrackIDs(accessToken) async {
  // Gets the user's recently played tracks.
  // Returns a list of track IDs.
  // Each track ID is a string.

  var url = 'https://api.spotify.com/v1/me/player/recently-played?limit=50';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  var responseJson = json.decode(response.body);
  var tracks = responseJson['items'].map((item) {
    return item['track']['id'];
  }).toList();
  return tracks;
}

Future getTracksAudioFeatures(accessToken, trackIDs) async {
  // Gets audio features for a list of tracks.
  // Returns a list of maps containing the audio features.

  var url =
      'https://api.spotify.com/v1/audio-features?ids=${getCommaSeparatedString(trackIDs)}';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  return json.decode(response.body)['audio_features'];
}

Future getListeningAnalysis(accessToken, trackIDs) async {
  // Gets the listening analysis for the given list of track IDs.
  // Access token is required.

  var audioFeatures = await getTracksAudioFeatures(accessToken, trackIDs);

  // Get the average of features of all songs listened to by the user
  var avgMap = {
    'acousticness': getAverageX(audioFeatures, 'acousticness'),
    'danceability': getAverageX(audioFeatures, 'danceability'),
    'energy': getAverageX(audioFeatures, 'energy'),
    'instrumentalness': getAverageX(audioFeatures, 'instrumentalness'),
    'speechiness': getAverageX(audioFeatures, 'speechiness'),
    'valence': getAverageX(audioFeatures, 'valence'),
  };

  return avgMap;
}

Future getTracksData(accessToken, tracksList) async {
  // Returns a list of track data for the given list of tracks.
  // Each individual list item contains data of a single track.

  var url =
      'https://api.spotify.com/v1/tracks?ids=${getCommaSeparatedString(tracksList)}';

  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  return json.decode(response.body)['tracks'];
}

Future getPopularities(accessToken, tracksList) async {
  // Returns a list of popularity values for the given list of tracks.
  // Values are mapped as: trackID -> popularity.

  var tracksData = await getTracksData(accessToken, tracksList);

  // Store the trackID and popularity in a map
  var popularityMap = {};
  for (var track in tracksData) {
    popularityMap[track['id']] = track['popularity'];
  }
  return popularityMap;
}

Future getReleaseDates(accessToken, tracksList) async {
  // Returns a list of release dates for the given list of tracks.
  // Values are mapped as: trackID -> releaseDate.

  var tracksData = await getTracksData(accessToken, tracksList);

  // Store the trackID and release date in a map
  var releaseDateMap = {};
  for (var track in tracksData) {
    releaseDateMap[track['id']] = track['album']['release_date'];
  }
  return releaseDateMap;
}

Future getSavedTracks(accessToken) async {
  // Gets the user's saved tracks, better known as Liked Songs on Spotify
  // Returns a list of track IDs.

  var url = 'https://api.spotify.com/v1/me/tracks?limit=50';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  return json
      .decode(response.body)['items']
      .map((item) => item['track']['id'])
      .toList();
}
Future getTrackData(accessToken, trackID) async {
  // Gets the track data for a given track ID.
  // Returns a map of track data containing
  // the name, artist, and cover image of the track

  var url = 'https://api.spotify.com/v1/tracks/$trackID';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  var trackData = {
    'name': json.decode(response.body)['name'],
    'artist': json.decode(response.body)['artists'][0]['name'],
    'coverImage': json.decode(response.body)['album']['images'][0]['url']
  };
  return trackData;
}

Future getMostAndLeastPopularTracks(accessToken) async {
  // Gets the most popular song and the least popular song from 
  // the user's Liked Songs on Spotify.

  // Get the popularity of Liked Songs
  var likedTracks = await getSavedTracks(accessToken);
  var popularityMap = await getPopularities(accessToken, likedTracks);

  // Get the most and least popular tracks
  var mostPopular = popularityMap.keys
      .reduce((a, b) => popularityMap[a] > popularityMap[b] ? a : b);
  var leastPopular = popularityMap.keys
      .reduce((a, b) => popularityMap[a] < popularityMap[b] ? a : b);

  // Return track data for the tracks
  mostPopular = await getTrackData(accessToken, mostPopular);
  leastPopular = await getTrackData(accessToken, leastPopular);
  return [mostPopular, leastPopular];
}

Future getLongestAndShortest(accessToken) async {
  // Gets the longest song and the shortest song by duration from 
  // the user's Liked Songs on Spotify.

  // Get the durations of Liked Songs
  var likedTracks = await getSavedTracks(accessToken);
  var tracksData = await getTracksData(accessToken, likedTracks);

  // Get the longest and shortest tracks
  var longest = tracksData.reduce((a, b) {
    return a['duration_ms'] > b['duration_ms'] ? a : b;
  });
  var shortest = tracksData.reduce((a, b) {
    return a['duration_ms'] < b['duration_ms'] ? a : b;
  });

  // Return track data for the tracks
  longest = await getTrackData(accessToken, longest['id']);
  shortest = await getTrackData(accessToken, shortest['id']);
  return [longest, shortest];
}


Future getEarliestAndLatest(accessToken) async {
  // Gets the most popular song and the least popular song from 
  // the user's Liked Songs on Spotify.
  var likedTracks = await getSavedTracks(accessToken);
  var releaseDateMap = await getReleaseDates(accessToken, likedTracks);

  // Get the earliest and latest tracks
  var latest = releaseDateMap.keys.reduce(
      (a, b) => dateCompare(releaseDateMap[a], releaseDateMap[b]) ? a : b);
  var earliest = releaseDateMap.keys.reduce(
      (a, b) => dateCompare(releaseDateMap[a], releaseDateMap[b]) ? b : a);

  earliest = await getTrackData(accessToken, earliest);
  latest = await getTrackData(accessToken, latest);
  return [earliest, latest];
}

Future getImageUrlFromTrackID(accessToken, trackID) async {
  var url = 'https://api.spotify.com/v1/tracks/$trackID';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  return json.decode(response.body)['album']['images'][0]['url'];
}

Future getImageUrlFromArtistID(accessToken, artistID) async {
  var url = 'https://api.spotify.com/v1/artists/$artistID';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  return json.decode(response.body)['images'][0]['url'];
}

Future getUserID(accessToken) async {
  var url = 'https://api.spotify.com/v1/me';
  var client = Client();
  var response = await client.get(Uri.parse(url), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  return json.decode(response.body)['id'];
}

Future createPlaylist(accessToken, userID) async {
  // Create a new playlist on Spotify
  var url = 'https://api.spotify.com/v1/users/$userID/playlists';
  var client = Client();
  var response = await client.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({
        'name': 'My Statify Playlist',
        'description': 'Created from Statify recommendations',
        'public': false,
      }));

  // returns the playlist ID
  return json.decode(response.body)['id'];
}

Future saveTracksAsPlaylist(accessToken, tracks) async {
  // Save tracks provided into a playlist

  // get user id
  var userID = await getUserID(accessToken);
  var playlistID = await createPlaylist(accessToken, userID);

  // populate playlist with tracks
  var client = Client();
  var trackUris =
      tracks.map((track) => 'spotify:track:${track['id']}').toList();
  trackUris = Uri.encodeQueryComponent(trackUris.join(','));
  var url =
      'https://api.spotify.com/v1/users/$userID/playlists/$playlistID/tracks?access_token=$accessToken&uris=$trackUris';
  // make request
  var populateResponse = await client.post(Uri.parse(url));

  return (populateResponse.statusCode == 201);
}

