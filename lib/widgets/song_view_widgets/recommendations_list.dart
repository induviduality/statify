// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

/*
  The RecommendedTracks Widget builds the list of recommendations
  generated from the seed song onto the SongView page.
  The list produced is scrollable.
*/

class RecommendedTracks extends StatefulWidget {
  final recommendedTracks;
  const RecommendedTracks({Key? key, required this.recommendedTracks})
      : super(key: key);
  @override
  State<RecommendedTracks> createState() => _RecommendedTracksState();
}

class _RecommendedTracksState extends State<RecommendedTracks> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.recommendedTracks.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(
                    widget.recommendedTracks[index]['coverImage']),
                title: Text(widget.recommendedTracks[index]['name'],
                    style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        color: Colors.white)),
                subtitle: Text(widget.recommendedTracks[index]['artist'],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w100,
                        color: Colors.grey[400])),
                hoverColor: const Color.fromARGB(29, 255, 255, 255),
                dense: false,
                visualDensity: VisualDensity.comfortable,
                onTap: () async {
                  html.window
                      .open(widget.recommendedTracks[index]['link'], "_blank");
                },
              );
            }),
      ],
    );
  }
}
