// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sheeshable/functions/session_controller.dart';
import 'package:sheeshable/utils/snackbar.dart';
import 'package:sheeshable/utils/url.dart';

import '../pages/homepage.dart';

SessionChecker sc = SessionChecker();
URL url = URL();

void login(String username, String password, BuildContext context) async {
  final Map<String, dynamic> jsonData = {
    "user": username,
    "password": password,
  };
  final Map<String, dynamic> queryParameters = {
    "operation": "login",
    "json": jsonEncode(jsonData),
  };

  try {
    http.Response response = await http
        .get(Uri.parse(url.apiUrl).replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      if (user['error'] != null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: MySnackBar(
        //       title: "Error:",
        //       message: user['error'],
        //       contentType: ContentType.failure,
        //     ),
        //   ),
        // );
        print("error here");
      } else {
        await sc.setSession(username, true, user["data"][0]["email"],
            user["data"][0]["fullname"], user["data"][0]["phone_number"]);
        print("Session?: ${sc.checkSession()}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } else {
      await sc.setSession("", false, "", "", "");
      print("Error: Something went wrong");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: MySnackBar(
      //       title: "Error",
      //       message: "Something went Wrong ${response.body}",
      //       contentType: ContentType.failure,
      //     ),
      //   ),
      // );
    }
  } catch (error) {
    print("Error: $error");
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: MySnackBar(
    //       title: "Error:",
    //       message: error.toString(),
    //       contentType: ContentType.failure,
    //     ),
    //   ),
    // );
    await sc.setSession("", false, "", "", "");
  }
}

void signup(String fullname, String username, String email, String password,
    String phoneNumber, BuildContext context) async {
  URL url = URL();

  final Map<String, dynamic> jsonData = {
    "fullname": fullname,
    "email": email,
    "username": username,
    "password": password,
    "phoneNumber": phoneNumber
  };

  final Map<String, dynamic> queryParams = {
    "operation": "signup",
    "json": jsonEncode(jsonData)
  };

  try {
    http.Response response = await http.post(
      Uri.parse(url.apiUrl),
      body: queryParams,
    );

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);
      if (user["error"] != null) {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: MySnackBar(
              title: "Error:",
              message: response.body,
              contentType: ContentType.failure,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: MySnackBar(
              title: "Success:",
              message: "Registration Successfull",
              contentType: ContentType.success,
            ),
          ),
        );
        Timer(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      }
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MySnackBar(
          title: "Error:",
          message: "Runtime Error: $error",
          contentType: ContentType.failure,
        ),
      ),
    );
  }
}
