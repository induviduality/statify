import 'package:flutter/material.dart';

class TopTracks extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final topTracksData;
  const TopTracks({Key? key, required this.topTracksData}) : super(key: key);

  @override
  State<TopTracks> createState() => _TopTracksState();
}

class _TopTracksState extends State<TopTracks> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      controller: _scrollController,
      itemCount: widget.topTracksData.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(children: [
          CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text((index + 1).toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 189, 189, 189)))),
          Text(widget.topTracksData[index][0],
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          const SizedBox(width: 12),
          Text(widget.topTracksData[index][1],
              style: const TextStyle(
                  color: Color.fromARGB(255, 171, 171, 171), fontSize: 18)),
        ]);
      },
    );
  }
}
