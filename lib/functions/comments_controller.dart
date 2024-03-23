import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sheeshable/utils/url.dart';

URL url = URL();
Future<Map<String, dynamic>?> getComments(int postId) async {
  final Map<String, dynamic> jsonData = {
    "post_id": postId
  };
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
