import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart';
import 'dart:core';
import '../config.dart' as config;

// This file contains all the functions used for User Authentication

const String clientID = config.clientID;
const String clientSecret = config.clientSecret;
const String redirectUri = config.redirectUri;

var scopeList = [
  'user-read-private',
  'user-library-read',
  'playlist-modify-public',
  'playlist-modify-private',
  'user-top-read',
  'user-read-recently-played',
  'user-follow-read',
  'user-library-read',
];

var scope = scopeList.join(' ');

Future getClientAccessToken() async {
  // Get the Client's access token
  var client = Client();
  var url = 'https://accounts.spotify.com/api/token';
  var body = {
    'grant_type': 'client_credentials',
  };
  var response = await client.post(Uri.parse(url), body: body, headers: {
    'Authorization':
        'Basic ${base64Encode(utf8.encode('$clientID:$clientSecret'))}',
  });
  return json.decode(response.body)['access_token'];
}

void getUserAuthorizationCode() async {
  // Authorize the User via the Web API and get the Authorization Code
  var url =
      'https://accounts.spotify.com/authorize?client_id=$clientID&response_type=code&redirect_uri=$redirectUri&scope=$scope';

  var request = Request('GET', Uri.parse(url));
  request.body =
      'client_id=$clientID&response_type=code&redirect_uri=$redirectUri&scope=$scope';

  // Makes a request to the url and redirects to the redirect_uri
  // The page redirect_uri will redirect back to the app
  // ignore: unused_local_variable
  var response = html.window.open(url, '_self');
}

Future getUserAccessToken(authorizationCode) async {
  // Get the Access Token in exchange for the Authorization Code
  var url = 'https://accounts.spotify.com/api/token';
  var body = {
    'grant_type': 'authorization_code',
    'code': authorizationCode,
    'redirect_uri': redirectUri,
  };
  var client = Client();
  var response = await client.post(Uri.parse(url), body: body, headers: {
    'Authorization':
        'Basic ${base64Encode(utf8.encode('$clientID:$clientSecret'))}',
  });
  return json.decode(response.body)['access_token'];
}
