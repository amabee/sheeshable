import 'package:flutter/material.dart';
import 'package:sheeshable/utils/bubble_stories.dart';
import 'package:sheeshable/utils/user_posts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final people = [
    "Paul Sho",
    "Yskaela",
    "Chinachi",
    "JillyAce",
    "Flare",
    "Christine Co",
    "Danielle Marsh",
    "Hanni Pham",
    "Minji Kim",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Sheeshable",
              style: TextStyle(fontFamily: "FSP-BOLD", fontSize: 30),
            ),
            Row(
              children: [
                Icon(Icons.favorite_border),
                Padding(padding: const EdgeInsets.all(7.0)),
                Icon(Icons.messenger_outline)
              ],
            )
          ],
        ),
      ),
      body: Column(children: [
        Container(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: people.length,
            itemBuilder: (context, index) {
              return BubbleStories(people: people[index]);
            },
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: people.length,
              itemBuilder: (context, index) {
                return UserPosts(name: people[index]);
              }),
        )
      ]),
    );
  }
}
