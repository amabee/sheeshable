import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/comments_controller.dart';
import 'package:sheeshable/functions/retrieveHomeData_controller.dart';
import 'package:sheeshable/utils/bubble_stories.dart';
import 'package:sheeshable/utils/user_posts.dart';

import '../functions/session_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> followers = [];

  final sessionChecker = SessionChecker();
  String username = "";
  String myImage = "";
  @override
  void initState() {
    sessionChecker.checkSession();
    _initHive();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _initHive() async {
    final box = await Hive.openBox('myBox');
    final myFollowers = await getFollowers(box.get("username"));
    setState(() {
      followers = myFollowers;
      username = box.get("username");
      myImage = box.get("image");
    });
  }

  Future<List<dynamic>> _fetchPosts() async {
    final box = await Hive.openBox('myBox');
    final getPost = await getPosts(box.get("username"), box.get("username"));
    return getPost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Sheeshable",
              style: TextStyle(fontFamily: "FSP-BOLD", fontSize: 30),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.favorite_border),
                  onTap: () async {
                    final box = await Hive.openBox('myBox');
                    getPosts(box.get("username"), "");
                  },
                ),
                Padding(padding: const EdgeInsets.all(7.0)),
                Icon(Icons.messenger_outline)
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: followers.length,
              itemBuilder: (context, index) {
                return BubbleStories(
                  people: followers[index]["following_id"],
                  peopleImage: followers[index]["image"],
                );
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder(
              future: _fetchPosts(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<dynamic> posts_list = snapshot.data ?? [];
                  posts_list.sort((a, b) => DateTime.parse(b["date_posted"])
                      .compareTo(DateTime.parse(a["date_posted"])));

                  return ListView.builder(
                    itemCount: posts_list.length,
                    itemBuilder: (context, index) {
                      final postImage = posts_list[index]["image"];
                      final followingId = posts_list[index]["following_id"];
                      final isMyPost = followingId == username;

                      if (isMyPost) {
                        // Handle displaying your own post differently
                        return UserPosts(
                          name: "@$followingId",
                          profileImage: myImage,
                          postImage: postImage,
                          postId: posts_list[index]["post_id"],
                          postCaption: posts_list[index]["caption"],
                        );
                      } else {
                        // Handle displaying other users' posts
                        final followerIndex = followers.indexWhere((follower) =>
                            follower["following_id"] == followingId);
                        if (followerIndex != -1) {
                          return UserPosts(
                            name: "@$followingId",
                            profileImage: followers[followerIndex]["image"],
                            postImage: postImage,
                            postId: posts_list[index]["post_id"],
                            postCaption: posts_list[index]["caption"],
                          );
                        } else {
                          return Container();
                        }
                      }
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
