import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/authentication_controller.dart';

void followUser(String tfollow) async {
  final box = await Hive.openBox("myBox");

  final Map<String, dynamic> json = {
    "cuser": box.get("username"),
    "tfollow": tfollow
  };

  final Map<String, dynamic> queryParams = {
    "operation": "followuser",
    "json": jsonEncode(json)
  };

  try {
    http.Response res = await http.post(
      Uri.parse(url.apiUrl),
      body: queryParams,
    );

    if (res.statusCode == 200) {
      dynamic jsonResponse = res.body;
      if (jsonResponse == "[Now Following]") {
        print("Now Following.");
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

Future<int> isFollowing(String username) async {
  final box = await Hive.openBox("myBox");

  final Map<String, dynamic> json = {
    "flwerid": box.get("username"),
    "flwingid": username
  };
  print(json);
  final Map<String, dynamic> queryParams = {
    "operation": "isfollowing",
    "json": jsonEncode(json),
  };

  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Is Following Count: $data");
      return data;
    } else {
      print("Server Error: ${response.statusCode}");
      return 0;
    }
  } catch (error) {
    print(error);
    return 0;
  }
}
