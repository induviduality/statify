import 'package:flutter/material.dart';

// Basically a 404 Page in Flutter.

class UndefinedView extends StatelessWidget {
  const UndefinedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Route is not defined'),
      ),
    );
  }
}
