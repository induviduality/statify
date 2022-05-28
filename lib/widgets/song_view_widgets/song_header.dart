import 'package:flutter/material.dart';

class SongHeader extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final song;
  const SongHeader({Key? key, required this.song}) : super(key: key);

  @override
  State<SongHeader> createState() => _SongHeaderState();
}

class _SongHeaderState extends State<SongHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
          width: 300,
          height: 300,
          child: Image.network(widget.song['coverImage']),
        ),
        const SizedBox(width: 30.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.song['name'], style: const TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.w900)),
              const SizedBox(height: 6.0),
              Text(
                widget.song['artist'],
                style: const TextStyle(fontSize: 32,
                  color: Color.fromARGB(255, 189, 189, 189
                ) ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
