import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sheeshable/models/LikedPost.dart';
import 'package:sheeshable/utils/url.dart';

URL url = URL();
Future<Map<String, dynamic>?> getLikes(String username, int postId) async {
  final Map<String, dynamic> jsonData = {
    "username": username,
    "post_id": postId
  };
  final Map<String, dynamic> queryParameters = {
    "operation": "getMyLikes",
    "json": jsonEncode(jsonData),
  };
  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParameters));

  try {
    if (response.statusCode == 200) {
      dynamic responseData = jsonDecode(response.body);
      if (responseData is List) {
        return responseData.isNotEmpty ? responseData.first : null;
      } else if (responseData is Map<String, dynamic>) {
        return responseData;
      } else {
        print("Invalid response format");
        return null;
      }
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (error) {
    print("Runtime Error: $error\nResponse: ${response.body}");
    return null;
  }
}

void likePost(int pid, String username) async {
  final Map<String, dynamic> jsonData = {"username": username, "post_id": pid};

  final Map<String, dynamic> queryParams = {
    "operation": "likepost",
    "json": jsonEncode(jsonData)
  };

  http.Response response = await http.post(
    Uri.parse(url.apiUrl),
    body: queryParams,
  );

  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey("error")) {
        String errorMessage = jsonResponse["error"];
        print("Error: $errorMessage");
      } else {
        print(jsonResponse);
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error: $error");
  }
}

void unlikePost(int pid, String username) async {
  final Map<String, dynamic> jsonData = {"username": username, "post_id": pid};

  final Map<String, dynamic> queryParams = {
    "operation": "unlikepost",
    "json": jsonEncode(jsonData)
  };

  http.Response response = await http.post(
    Uri.parse(url.apiUrl),
    body: queryParams,
  );

  try {
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey("error")) {
        String errorMessage = jsonResponse["error"];
        print("Error: $errorMessage");
      } else {
        print(jsonResponse);
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (error) {
    print("Error: $error");
  }
}

