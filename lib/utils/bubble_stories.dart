import 'package:flutter/material.dart';
import 'package:sheeshable/functions/authentication_controller.dart';

class BubbleStories extends StatelessWidget {
  final String people;
  final String peopleImage;
  const BubbleStories(
      {super.key, required this.people, required this.peopleImage});

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
                color: peopleImage.isEmpty ? Colors.grey[200] : null,
                image: peopleImage.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(url.imageUrl + peopleImage),
                        fit: BoxFit.cover,
                      )
                    : null,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(people, style: TextStyle(fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
