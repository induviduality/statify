// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final coverImage;
  final trackName;
  final artistName;
  
  const CustomListTile({
    Key? key,
    required this.coverImage,
    required this.trackName,
    required this.artistName
  }) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          width: 80,
          height: 80,
          child: Image.network(widget.coverImage),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.trackName,
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 8.0),
              Text(
                widget.artistName,
                style: const TextStyle(fontSize: 16, color: Color.fromARGB(255, 189, 189, 189)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
