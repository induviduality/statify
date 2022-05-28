// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:statify/themes/maintheme.dart';
import 'package:statify/widgets/custom_list_tiles.dart';

AppTheme currentTheme = AppTheme();

class ByReleaseDateCard extends StatefulWidget {
  final releaseDateExtremes;
  const ByReleaseDateCard({Key? key, required this.releaseDateExtremes}) : super(key: key);

  @override
  State<ByReleaseDateCard> createState() => _ByReleaseDateCardState();
}

class _ByReleaseDateCardState extends State<ByReleaseDateCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: const Color.fromARGB(255, 20, 23, 28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        width: 400,
        height: 350,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('Latest Track',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            const SizedBox(height: 15),
            CustomListTile(
              coverImage: widget.releaseDateExtremes[0]['coverImage'],
              trackName: widget.releaseDateExtremes[0]['name'],
              artistName: widget.releaseDateExtremes[0]['artist'],
            ),
            const SizedBox(height: 30),
            const Text('Earliest Track',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
            const SizedBox(height: 15),
            CustomListTile(
              coverImage: widget.releaseDateExtremes[1]['coverImage'],
              trackName: widget.releaseDateExtremes[1]['name'],
              artistName: widget.releaseDateExtremes[1]['artist'],
            ), 
          ],
        ),
      ),
    );
  }
}