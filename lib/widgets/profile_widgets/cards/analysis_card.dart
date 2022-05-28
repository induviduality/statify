// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:statify/themes/maintheme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

AppTheme currentTheme = AppTheme();

class AnalysisCard extends StatefulWidget {
  final featuresData;
  const AnalysisCard({Key? key, required this.featuresData}) : super(key: key);

  @override
  State<AnalysisCard> createState() => _AnalysisCardState();
}

class _AnalysisCardState extends State<AnalysisCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: const Color.fromARGB(255, 20, 23, 28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: SizedBox(
        width: 800,
        height: 330,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Stats(
                    name: 'acousticness',
                    value: widget.featuresData['acousticness']),
                const SizedBox(width: 100),
                Stats(
                    name: 'danceability',
                    value: widget.featuresData['danceability']),
                const SizedBox(width: 100),
                Stats(name: 'energy', value: widget.featuresData['energy']),
              ],
            ),
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 50),
                Stats(
                    name: 'instrumentalness',
                    value: widget.featuresData['instrumentalness']),
                const SizedBox(width: 187),
                Stats(
                    name: 'speechiness',
                    value: widget.featuresData['speechiness']),
                const SizedBox(width: 150),
                Stats(name: 'valence', value: widget.featuresData['valence']),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Stats extends StatefulWidget {
  final name;
  final value;
  const Stats({Key? key, required this.name, required this.value})
      : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  getDesc(feature) {
    // check if feature is in description
    // if so, return description
    var description = {
      'acousticness': 'Music with no electronic sounds',
      'danceability': 'Music that makes you want to move it',
      'energy': 'Music that feels fast and alive',
      'instrumentalness': 'Music with no vocals',
      'speechiness': 'Music with mostly spoken words',
      'valence': 'Cheerfulness of your music'
    };

    if (description.containsKey(feature)) {
      return description[feature];
    } else {
      return 'Audio Feature';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.ltr,
      children: [
        Text(widget.name,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Color.fromARGB(255, 255, 255, 255)),
            textDirection: TextDirection.ltr),
        const SizedBox(height: 15),
        // percentage indicator
        LinearPercentIndicator(
          padding: const EdgeInsets.all(0),
          width: 200.0,
          lineHeight: 12.0,
          percent: widget.value,
          backgroundColor: const Color.fromARGB(255, 73, 77, 84),
          progressColor: const Color.fromARGB(255, 7, 194, 113),
          barRadius: const Radius.circular(10),
        ),
        const SizedBox(height: 15),
        // short description of the stat
        Text(getDesc(widget.name),
            style: const TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 18,
                color: Color.fromARGB(255, 189, 189, 189)),
            textDirection: TextDirection.ltr),
      ],
    );
  }
}
