import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/authentication_controller.dart';

void createPost(
    String imageName, String caption, File imageFile) async {
  final box = await Hive.openBox("myBox");

  final Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
  };

  final Uri uri = Uri.parse(url.apiUrl);

  var request = http.MultipartRequest('POST', uri)
    ..fields['operation'] = 'createPost'
    ..fields['json'] = jsonEncode({
      "image": imageName,
      "caption": caption,
      "posted_by": box.get("username")
    })
    ..files.add(http.MultipartFile(
        'image', imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
        filename: imageName));

  try {
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      if (jsonResponse == "[Post created]") {
        print("Post created successfully.");
      } else {
        print("Unexpected response: $jsonResponse");
      }
    } else {
      print("Error with the status code of: ${response.statusCode}");
    }
  } catch (error) {
    print("Runtime Error: $error");
  }
}
