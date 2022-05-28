import 'package:flutter/material.dart';

import 'package:statify/widgets/custom_list_tiles.dart';
import 'package:statify/themes/maintheme.dart';
import 'package:statify/bloc/string_helpers.dart';

AppTheme currentTheme = AppTheme();

class ByPopularityCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final popularityExtremes;
  const ByPopularityCard({Key? key, required this.popularityExtremes})
      : super(key: key);

  @override
  State<ByPopularityCard> createState() => _ByPopularityCardState();
}

class _ByPopularityCardState extends State<ByPopularityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: const Color.fromARGB(255, 20, 23, 28),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        width: 380,
        height: 350,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text('Most Popular',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            const SizedBox(height: 15),
            CustomListTile(
              coverImage: widget.popularityExtremes[0]['coverImage'],
              trackName:
                  truncateString(widget.popularityExtremes[0]['name'], 17),
              artistName:
                  truncateString(widget.popularityExtremes[0]['artist'], 17),
            ),
            const SizedBox(height: 30),
            const Text('Most Obscure',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
            const SizedBox(height: 15),
            CustomListTile(
              coverImage: widget.popularityExtremes[1]['coverImage'],
              trackName:
                  truncateString(widget.popularityExtremes[1]['name'], 17),
              artistName:
                  truncateString(widget.popularityExtremes[1]['artist'], 17),
            ),
          ],
        ),
      ),
    );
  }
}
