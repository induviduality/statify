// ignore_for_file: prefer_typing_uninitialized_variables

class UserProfileArguments {
  final userProfileData;
  final topArtists;
  final featuresData;
  final topTracks;
  final accessToken;
  final popularityExtremes;
  final durationExtremes;
  final releaseDateExtremes;

  UserProfileArguments({
    this.userProfileData,
    this.topArtists,
    this.featuresData,
    this.topTracks,
    this.accessToken,
    this.popularityExtremes,
    this.durationExtremes,
    this.releaseDateExtremes,
  });
}

class SearchArguments {
  final accessToken;

  SearchArguments({
    this.accessToken,
  });
}
