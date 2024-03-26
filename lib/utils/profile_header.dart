// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/authentication_controller.dart';
import 'package:sheeshable/functions/follow_controller.dart';
import 'package:sheeshable/functions/profilePage_details.dart';
import 'package:sheeshable/utils/url.dart';

class ProfileHeaderWidget extends StatefulWidget {
  String imageLink;
  String username;
  ProfileHeaderWidget(
      {super.key, required this.imageLink, required this.username});

  @override
  _ProfileHeaderWidgetState createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  bool isMe = false;
  int followersCount = 0;
  int followingCount = 0;
  int postscount = 0;
  int isfollow = 0;
  bool displayFollow = true;

  void isMeRightNow(String username) async {
    final box = await Hive.openBox("myBox");

    if (username == box.get("username")) {
      print("Current User: ${box.get("username")}");
      setState(() {
        isMe = true;
      });
    } else {
      setState(() {
        isMe = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isMeRightNow(widget.username);
    getFollowers();
    followCheck();
  }

  void getFollowers() async {
    int followers = await getFollowerCount(widget.username);
    int following = await getFollowingCount(widget.username);
    int postcount = await getPostsCount(widget.username);
    setState(() {
      followersCount = followers;
      followingCount = following;
      postscount = postcount;
    });
  }

  void followCheck() async {
    int followchecker = await isFollowing(widget.username);

    if (followchecker == 1) {
      setState(() {
        displayFollow = false;
      });
    } else {
      setState(() {
        displayFollow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xff74EDED),
                  backgroundImage:
                      NetworkImage("${url.imageUrl}/${widget.imageLink}"),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "$postscount",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Text(
                          "Posts",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.4,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          "$followersCount",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Text(
                          "$followingCount", // Display following count
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${widget.username}",
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              "Bio",
              style: TextStyle(
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            actions(context),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget actions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: const Size(20, 40),
                side: BorderSide(
                  color: Colors.grey.shade100,
                ),
                backgroundColor:
                    !isMe ? Colors.blue.shade500 : Colors.transparent),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: !isMe && displayFollow
                  ? GestureDetector(
                      onTap: () {
                        followUser(widget.username);
                        setState(() {
                          followingCount++;
                          displayFollow = false;
                        });
                      },
                      child: const Text(
                        "Follow",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  : !isMe && !displayFollow
                      ? const Text(
                          "Following",
                          style: TextStyle(color: Colors.black),
                        )
                      : const Text(
                          "Edit Profile",
                          style: TextStyle(color: Colors.black),
                        ),
            ),
          ),
        ),
      ],
    );
  }
}
