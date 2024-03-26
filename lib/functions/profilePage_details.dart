import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sheeshable/utils/url.dart';

Future<int> getFollowerCount(String username) async {
  URL url = URL();
  final Map<String, dynamic> json = {"fc": username};
  final Map<String, dynamic> queryParams = {
    "operation": "getfollowercount",
    "json": jsonEncode(json),
  };

  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Following Count: $data");
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

Future<int> getFollowingCount(String username) async {
  URL url = URL();
  final Map<String, dynamic> json = {"fc": username};
  final Map<String, dynamic> queryParams = {
    "operation": "getfollowingcount",
    "json": jsonEncode(json),
  };

  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Following Count: $data");
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

Future<int> getPostsCount(String username) async {
  URL url = URL();
  final Map<String, dynamic> json = {"pbid": username};
  final Map<String, dynamic> queryParams = {
    "operation": "getpostcount",
    "json": jsonEncode(json),
  };

  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParams));

  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Post Count: $data");
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