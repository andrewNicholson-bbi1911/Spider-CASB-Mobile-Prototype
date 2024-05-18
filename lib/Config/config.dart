import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Config{
  static const String SpiderCasbAPIBaseURL = "http://192.168.0.101:5000/api";

  static const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    hintStyle: TextStyle(fontSize: 14),
    border: InputBorder.none,
  );

  static const kMessageContainerDecoration = BoxDecoration(
  );
// border: Border(
//   top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
}