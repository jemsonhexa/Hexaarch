import 'package:flutter/material.dart';

PreferredSizeWidget commonAppbar(BuildContext context, String text) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    centerTitle: true,
  );
}
