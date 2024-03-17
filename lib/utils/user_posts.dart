import 'package:flutter/material.dart';

class UserPosts extends StatelessWidget {
  final String name;
  const UserPosts({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // PROFILE PHOTO AREA
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  // USER NAME
                  Text(
                    name,
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        ),
        // post
        Container(
          height: 300,
          color: Colors.grey[300],
        ),
        const Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border_outlined, size: 30.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Icon(Icons.messenger_outline_rounded, size: 30.0),
                  ),
                  Icon(Icons.send_rounded, size: 30.0),
                ],
              ),
              Icon(Icons.bookmark_outline_rounded, size: 30.0)
            ],
          ),
        ),

        // COMMENTS
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              Text("Liked by "),
              Text(
                "Yskaela ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "and ",
              ),
              Text(
                "others",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
