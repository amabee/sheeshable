import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MySnackBar extends StatelessWidget {
  String title;
  String message;
  ContentType contentType;
  MySnackBar(
      {super.key,
      required this.title,
      required this.message,
      required this.contentType});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: AwesomeSnackbarContent(
        titleFontSize: 17,
        title: title,
        message: message,
        contentType: contentType,
      ),
    );
  }
}
