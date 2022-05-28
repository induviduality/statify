import 'package:flutter/material.dart';

class Heading extends StatefulWidget {
  final String title;
  const Heading({Key? key, required this.title}) : super(key: key);

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 45, 15, 0),
          child: Text(widget.title,
              style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ],
    );
  }
}
