import 'package:flutter/material.dart';
import 'package:statify/themes/maintheme.dart';

AppTheme currentTheme = AppTheme();

class UserHeader extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final userProfileData;
  const UserHeader({Key? key, required this.userProfileData}) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  getUserProfileImage(user) {
    if (user['images'] != []) {
      return user['images'][0]['url'];
    } else {
      return 'https://us.123rf.com/450wm/tifani1/tifani11801/tifani1180100032/93016694-user-icon-vector-illustration-on-black-background.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3,
              ),
              shape: BoxShape.circle,
              image: DecorationImage(
                image:
                    NetworkImage(getUserProfileImage(widget.userProfileData)),
                fit: BoxFit.cover,
              ),
            )),
        const SizedBox(width: 60),
        Text(
          widget.userProfileData['display_name'],
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
