import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Config{
  static const String SpiderCasbAPIBaseURL = "http://31.129.103.123:5002/api";

  static const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    hintStyle: TextStyle(fontSize: 14),
    border: InputBorder.none,
  );

  static const kMessageContainerDecoration = BoxDecoration(
  );

  static const List<Color> urgencyColors = [Colors.blue, Colors.blue, Colors.green, Colors.yellow, Colors.red];

}