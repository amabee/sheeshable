import 'package:flutter/material.dart';

class DraggableBottomSheet extends StatefulWidget {
  String image;
  DraggableBottomSheet({Key? key, required this.image}) : super(key: key);

  @override
  _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: Colors.white,
          height: 50,
          child: Center(
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.black45,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(16)),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                  Text("Hello"),
                ],
              ),
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
                                print("Sent");
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
