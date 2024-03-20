import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sheeshable/models/LikedPost.dart';
import 'package:sheeshable/utils/url.dart';

Future<List<LikeData>> getLikes(String username, int post_id) async {
  URL url = URL();

  final Map<String, dynamic> jsonData = {
    "username": username,
    "post_id": post_id
  };
  final Map<String, dynamic> queryParameters = {
    "operation": "getMyLikes",
    "json": jsonEncode(jsonData),
  };

  try {
    http.Response response = await http
        .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      var likedData = jsonDecode(response.body);
      if (likedData is List) {
        List<LikeData> likes =
            likedData.map<LikeData>((like) => LikeData.fromJson(like)).toList();
        print("Likes: $likes\n likedData: $likedData");
        return likes;
      } else {
        print("Invalid response format");
        return [];
      }
    } else {
      print("Error: ${response.statusCode}");
      return [];
    }
  } catch (error) {
    print("Runtime Error: $error");
    return [];
  }
}
