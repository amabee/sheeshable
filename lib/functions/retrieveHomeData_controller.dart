import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sheeshable/utils/url.dart';

Future<List> getPosts(String follower_id) async {
  try {
    URL url = URL();
    final Map<String, dynamic> jsonData = {
      "follower_id": follower_id,
    };
    final Map<String, dynamic> queryParams = {
      "operation": "getPosts",
      "json": jsonEncode(jsonData),
    };
    http.Response response = await http
        .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result is List && result.isNotEmpty) {
        // print("Result: $result");
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

Future<List> getFollowers(String follower_id) async {
  try {
    URL url = URL();
    final Map<String, dynamic> jsonData = {
      "follower_id": follower_id,
    };
    final Map<String, dynamic> queryParams = {
      "operation": "getFollowers",
      "json": jsonEncode(jsonData),
    };
    http.Response response = await http
        .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result is List && result.isNotEmpty) {
        return result;
      } else {
        print("Error Retrieving Followers");
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
