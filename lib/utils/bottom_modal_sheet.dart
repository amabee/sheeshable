// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:sheeshable/functions/comments_controller.dart';

class DraggableBottomSheet extends StatefulWidget {
  String image;
  int pid;
  DraggableBottomSheet({Key? key, required this.image, required this.pid})
      : super(key: key);

  @override
  _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  List<dynamic> comments = [];
  @override
  void initState() {
    super.initState();
    getAllComments();
  }

  void getAllComments() async {
    List<dynamic> fetchedComments = await getComments(widget.pid);
    setState(() {
      comments = fetchedComments;
    });
  }

  void addCommentAndUpdate(String newComment) {
    addComment(widget.pid, newComment);
    getAllComments();
  }

  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 80,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 30,
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Center(
                    child: Text(
                  "Comments",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ))
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: FutureBuilder(
              future: getComments(widget.pid),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No comments yet.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        Text(
                          "Start the conversation.",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  );
                } else {
                  List<dynamic> comments = snapshot.data ?? [];
                  return SingleChildScrollView(
                    child: Column(
                      children: comments.map((comment) {
                        return InstagramCommentCard(
                          username: comment['username'],
                          comment: comment['comment'],
                          commenterImage: comment['image'],
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  maxRadius: 24,
                  minRadius: 24,
                ),
                Expanded(
                  // Wrap TextField with Expanded
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Comment...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16.0,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                if (commentController.text.length > 5) {
                                  addCommentAndUpdate(commentController.text);
                                  commentController.clear();
                                } else {
                                  print("Invalid Length");
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InstagramCommentCard extends StatefulWidget {
  String username;
  String comment;
  String commenterImage;
  InstagramCommentCard(
      {Key? key,
      required this.username,
      required this.comment,
      required this.commenterImage})
      : super(key: key);

  @override
  _InstagramCommentCardState createState() => _InstagramCommentCardState();
}

class _InstagramCommentCardState extends State<InstagramCommentCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage('${url.imageUrl}/${widget.commenterImage}'),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Wrap(
                    children: [
                      Text(
                        widget.comment,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        child: Icon(
                          !isLiked
                              ? Icons.favorite_border
                              : Icons.favorite_sharp,
                          size: 18.0,
                          color: !isLiked ? Colors.grey : Colors.red,
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      const Text(
                        '0',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
