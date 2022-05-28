import 'package:flutter/material.dart';

import '../bloc/argument_models.dart';
import 'route_names.dart';

import '../pages/menu.dart';
import '../pages/auth_intermediate.dart';
import '../pages/user_profile.dart';
import '../pages/search_screen.dart';
import '../pages/undefined_view.dart';

class AuthArguments {
  final String authorizationCode;
  AuthArguments(this.authorizationCode);
}

Route<dynamic> unknownRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (BuildContext context) => const UndefinedView(),
  );
}

Route<dynamic> generateRoute(RouteSettings settings) {
  // split settings.name by "?authorizationCode="
  final List<String> pathElements = settings.name!.split('?authorizationCode=');
  if (pathElements[0] == authRoute) {
    return MaterialPageRoute(
        builder: (context) => AuthIntermediatory(
              authorizationCode: pathElements[1],
            ));
  }

  switch (settings.name) {
    case homeRoute:
      return MaterialPageRoute(
        builder: (context) => const MenuScreen(),
      );
    case searchRoute:
      final args = settings.arguments as SearchArguments;
      return MaterialPageRoute(
        builder: (context) => SearchScreen(accessToken: args.accessToken),
      );
    case userProfileRoute:
      final args = settings.arguments as UserProfileArguments;
      return MaterialPageRoute(
        builder: (context) => UserProfile(
          userProfileData: args.userProfileData,
          topArtists: args.topArtists,
          featuresData: args.featuresData,
          topTracks: args.topTracks,
          accessToken: args.accessToken,
          popularityExtremes: args.popularityExtremes,
          durationExtremes: args.durationExtremes,
          releaseDateExtremes: args.releaseDateExtremes,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const UndefinedView(),
      );
  }
}
