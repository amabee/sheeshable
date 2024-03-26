// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/authentication_controller.dart';
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
                const Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Posts",
                          style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 0.4,
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
                          "0",
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
                          "0",
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
                minimumSize: Size(0, 30),
                side: BorderSide(
                  color: Colors.grey.shade400,
                ),
                backgroundColor:
                    !isMe ? Colors.blue.shade300 : Colors.transparent),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: !isMe
                  ? Text("Follow", style: TextStyle(color: Colors.black))
                  : Text("Edit Profile", style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ],
    );
  }
}
