import 'package:flutter/material.dart';
import './routing/router.dart' as router;
import './routing/route_names.dart';

import './themes/maintheme.dart';

AppTheme currentTheme = AppTheme();

void main(List<String> args) async {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Statify - Home',
      initialRoute: homeRoute,
      onGenerateRoute: router.generateRoute,
      onUnknownRoute: router.unknownRoute,
    );
  }
}