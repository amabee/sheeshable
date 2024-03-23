// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/likes_controller.dart';
import 'package:sheeshable/models/LikedPost.dart';
import 'package:sheeshable/utils/bottom_modal_sheet.dart';
import 'package:sheeshable/utils/url.dart';

class UserPosts extends StatefulWidget {
  final String name;
  final String profileImage;
  final String postImage;
  final String postCaption;
  final int postId;

  const UserPosts({
    Key? key,
    required this.name,
    required this.profileImage,
    required this.postImage,
    required this.postCaption,
    required this.postId,
  }) : super(key: key);

  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  bool isLiked = false;
  int likeCount = 0;
  LikeData likeData = LikeData();

  String likeMessage = "";

  @override
  void initState() {
    super.initState();
    getAllLike();
  }

  void getAllLike() async {
    final box = await Hive.openBox("myBox");
    Map<String, dynamic>? likedData =
        await getLikes(box.get("username"), widget.postId);

    if (likedData != null && likedData.containsKey('post_id')) {
      setState(() {
        likeCount = likedData['total_like_count'];
        isLiked = (likedData['user_like_count'] == "1");

        updateLikeMessage();
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (!isLiked) {
      setState(() {
        likeMessage = "You liked this post";
      });
    }
  }

  void updateLikeMessage() {
    if (isLiked && likeCount == 1) {
      likeMessage = "You Liked This Post";
    } else if (isLiked && likeCount > 1) {
      likeMessage = "You and ${likeCount - 1} others";
    } else if (!isLiked && likeCount > 1) {
      likeMessage = "${likeCount - 1} people liked this post";
    } else {
      likeMessage = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    URL url = URL();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                      shape: BoxShape.circle,
                      color:
                          widget.profileImage.isEmpty ? Colors.grey[300] : null,
                      image: widget.profileImage.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(
                                  url.imageUrl + widget.profileImage),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  // USER NAME
                  Text(
                    widget.name,
                    style: const TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const Icon(Icons.more_vert)
            ],
          ),
        ),
        // post
        Container(
          decoration: BoxDecoration(
              color: widget.postImage.isEmpty ? Colors.grey[300] : null,
              image: widget.postImage.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(url.imageUrl + widget.postImage),
                      fit: BoxFit.cover)
                  : null),
          height: 400,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                      size: 30.0,
                      color: isLiked ? Colors.red : null,
                    ),
                    onTap: () async {
                      final box = await Hive.openBox("myBox");
                      setState(() {
                        isLiked = !isLiked;
                        updateLikeMessage();
                        if (isLiked) {
                          likeMessage = "You liked this post";
                          likePost(widget.postId, box.get("username"));
                        } else {
                          likeMessage = "";
                          unlikePost(widget.postId, box.get("username"));
                        }
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      final box = await Hive.openBox("myBox");

                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return DraggableBottomSheet(
                            image: "${url.imageUrl}/${box.get("image")}",
                          );
                        },
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Icon(Icons.messenger_outline_rounded, size: 30.0),
                    ),
                  ),
                  Icon(Icons.send_rounded, size: 30.0),
                ],
              ),
              Icon(Icons.bookmark_outline_rounded, size: 30.0)
            ],
          ),
        ),

        // Liked
        if (isLiked || likeCount > 0)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                Text(
                  likeMessage,
                  style: const TextStyle(
                      fontSize: 13.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),

        // CAPTION
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 17.0),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: widget.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: " "),
                TextSpan(text: widget.postCaption)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
