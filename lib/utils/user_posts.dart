import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/getlikes.dart';
import 'package:sheeshable/models/LikedPost.dart';
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

  @override
  void initState() {
    super.initState();
    checkIfLiked();
  }

  Future<void> checkIfLiked() async {
  try {
    final box = await Hive.openBox('myBox');
    final username = box.get("username");
    final likedPosts = await getLikes(username, widget.postId);

    final isUserLiked = likedPosts.isNotEmpty;
    final totalLikeData = likedPosts.fold<LikeData>(
      LikeData(postId: widget.postId, likeCount: 0.toString()),
      (previousValue, element) => LikeData(
        postId: element.postId,
        likeCount: previousValue.likeCount + element.likeCount,
      ),
    );

    setState(() {
      isLiked = isUserLiked;
      likeCount = int.tryParse(totalLikeData.likeCount).toString() as int;
    });
  } catch (error) {
    print("Error checking if liked: $error");
    // Handle error or show a toast/snackbar
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
                  SizedBox(
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
                    onTap: () {
                      // Toggle like status
                      setState(() {
                        isLiked = !isLiked;
                      });
                      // // Update likes status in your database or wherever you store likes
                      // updateLikes(isLiked, widget.postId);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
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
              isLiked
                  ? Text(
                      "You Liked this post",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : Text("Liked by "),
              isLiked
                  ? SizedBox()
                  : Text(
                      "Yskaela ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              likeCount <= 1
                  ? Text("")
                  : Text(
                      "You and ",
                    ),
              likeCount <= 1
                  ? const SizedBox()
                  : Text(
                      " ${likeCount} others",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),

        // CAPTION
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 17.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: widget.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: " "),
                TextSpan(text: widget.postCaption)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
