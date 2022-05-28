// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TopArtists extends StatefulWidget {
  final artistsList;
  const TopArtists({Key? key, required this.artistsList}) : super(key: key);

  @override
  State<TopArtists> createState() => _TopArtistsState();
}

class _TopArtistsState extends State<TopArtists> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            controller: _scrollController,
            itemCount: widget.artistsList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row( 
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 189, 189, 189)
                      )
                    )
                  ),
                  Text(
                    widget.artistsList[index],
                    style: const TextStyle(
                      color: Colors.white, fontSize: 20)
                  ),
                ]
              );
            },
          );
  }
}