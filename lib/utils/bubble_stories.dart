import 'package:flutter/material.dart';

class BubbleStories extends StatelessWidget {
  final String people;
  const BubbleStories({super.key, required this.people});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(people)
        ],
      ),
    );
  }
}
