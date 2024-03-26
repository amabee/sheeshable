import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sheeshable/utils/url.dart';

Future<List> getImagePosts(String user) async {
  try {
    URL url = URL();
    final Map<String, dynamic> jsonData = {"user_id": user};
    final Map<String, dynamic> queryParams = {
      "operation": "getImagePosts",
      "json": jsonEncode(jsonData),
    };
    http.Response response = await http
        .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result is List && result.isNotEmpty) {
        print("Image Result: $result");
        return result;
      } else {
        //print("Error Retrieving Posts: ${response.body}");
        const CircularProgressIndicator();
        return [];
      }
    } else {
      return [];
    }
  } catch (error) {
    print("Error: $error");
    return [];
  }
}
