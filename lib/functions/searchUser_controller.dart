import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/utils/url.dart';

URL url = URL();

Future<List<dynamic>> getSearchedPerson(String sid) async {
  final Map<String, dynamic> jsonData = {"sid": sid};
  final Map<String, dynamic> queryParameters = {
    "operation": "searchpeople",
    "json": jsonEncode(jsonData),
  };
  http.Response response = await http
      .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParameters));

  try {
    if (response.statusCode == 200) {
      String jsonString = response.body.replaceAll("'", '"');
      dynamic responseData = jsonDecode(jsonString);
      if (responseData is List) {
        //print(responseData);
        return responseData.isNotEmpty ? responseData : [];
      } else {
        //print(responseData);
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
