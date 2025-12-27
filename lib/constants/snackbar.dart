import 'package:flutter/material.dart';

void customshowSnackBar(BuildContext context, String text, Color color) {
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: color,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
