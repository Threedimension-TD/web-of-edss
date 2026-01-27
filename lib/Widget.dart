import 'package:flutter/material.dart';

Widget buildTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

Widget buildCenterTitle(String title,Color color) {
  return Center(
    child: Text(
      title,
      style: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: color),
      ),
    );
}