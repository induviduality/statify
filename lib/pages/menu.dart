import 'package:flutter/material.dart';

import '../bloc/auth.dart';
import '../themes/maintheme.dart';

/*
  The MenuScreen is the main screen of the app. It is the starting 
  point of Statify.
  
  The Home() widget routes to the MenuScreen, so as to support routing
  functionality with the urls.
*/

AppTheme currentTheme = AppTheme();

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Statify - Home',
      theme: AppTheme.mainTheme,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 10, 12),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Statify',
                  style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w900,
                      color: Colors.white)),
              const SizedBox(height: 30),
              const Text('Think Spotify Wrapped - but a notch higher!',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(235, 18, 213, 129))),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('Sign in with Spotify',
                    style:
                        TextStyle(fontSize: 18, fontStyle: FontStyle.normal)),
                onPressed: () async {
                  getUserAuthorizationCode();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
