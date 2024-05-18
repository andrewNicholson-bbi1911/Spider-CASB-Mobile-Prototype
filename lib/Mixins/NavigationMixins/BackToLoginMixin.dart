import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

mixin BackToLoginScreenMixin{

  static const int needLoginCode = 401;

  dynamic backToLogin(Response<dynamic> resp, dynamic context){
    if(resp.statusCode == needLoginCode){
      Navigator.pushNamed(context as BuildContext, Navigator.defaultRouteName);
    }
  }
}