import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sheeshable/functions/comments_controller.dart';
import 'package:sheeshable/functions/posts_controller.dart';

class ImagePickerDemo extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemo> {
  File? _image;
  String? _caption;

  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _navigateToCaptionScreen();
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _navigateToCaptionScreen();
      } else {
        print('No image selected.');
      }
    });
  }

  void _navigateToCaptionScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CaptionScreen()),
    );

    if (result != null) {
      setState(() {
        _caption = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'New Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              createPost(_image!.path, _caption!, _image!);
            },
            icon: Icon(Icons.check, color: Colors.blue),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              _image == null
                  ? Text('No image selected.')
                  : Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: getImageFromCamera,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Take a Picture'),
                  ),
                  ElevatedButton(
                    onPressed: getImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Select from Gallery'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _caption != null
                  ? Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Caption:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(_caption!),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class CaptionScreen extends StatefulWidget {
  @override
  _CaptionScreenState createState() => _CaptionScreenState();
}

class _CaptionScreenState extends State<CaptionScreen> {
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Caption',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, _captionController.text);
            },
            icon: Icon(Icons.check, color: Colors.blue),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                labelText: 'Write a caption...',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
