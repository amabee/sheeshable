// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sheeshable/main.dart';

import '../pages/homepage.dart';

void login(
    BuildContext context,
    TextEditingController _usernameController,
    TextEditingController _passwordController,
    void Function(bool) setLoading) async {
  setLoading(true);

  String url = "";

  final Map<String, dynamic> queryParams = {
    "username": _usernameController.text,
    "password": _passwordController.text,
  };

  try {
    http.Response response =
        await http.get(Uri.parse(url).replace(queryParameters: queryParams));

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      print(user);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print("Error");
    }
  } catch (error) {
    print("Error: ${error}");
  } finally {
    setLoading(false);
  }
}
