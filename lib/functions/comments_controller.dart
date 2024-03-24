import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sheeshable/utils/url.dart';

URL url = URL();
Future<List<dynamic>> getComments(int postId) async {
  final Map<String, dynamic> jsonData = {"post_id": postId};
  final Map<String, dynamic> queryParameters = {
    "operation": "getcomments",
    "json": jsonEncode(jsonData),
  };
  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParameters));

  try {
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      if (responseData is List) {
        //print(responseData);
        return responseData.isNotEmpty ? responseData : [];
      } else {
        print("Invalid response format");
        return [];
      }
    } else {
      print("Error: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    print("Runtime Error: $error\nResponse: ${response.body}");
    return [];
  }
}

void addComment(int pid, String comment) async {
  final box = await Hive.openBox("myBox");

  final Map<String, dynamic> json = {
    "post_id": pid,
    "username": box.get("username"),
    "comment": comment
  };

  final Map<String, dynamic> queryParams = {
    "operation": "addcomment",
    "json": jsonEncode(json)
  };

  try {
    http.Response res = await http.post(
      Uri.parse(url.apiUrl),
      body: queryParams,
    );

    if (res.statusCode == 200) {
      dynamic jsonResponse = res.body;
      if (jsonResponse == "[Comment Posted]") {
        print("Comment posted successfully.");
      } else {
        print("Unexpected response: $jsonResponse");
      }
    } else {
      print("Error with the status code of: ${res.statusCode}");
    }
  } catch (error) {
    print("Runtime Error: $error");
  }
}
