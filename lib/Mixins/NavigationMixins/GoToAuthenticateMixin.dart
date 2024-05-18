import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

mixin GoToAuthenticateMixin{

  static const int needAuthenticateCode = 440;
  static const String authRouteName = "/authenticate";

  bool goToAuthenticate(Response<dynamic> resp, dynamic context, {Function(dynamic)? onAuthenticated}){
    if(resp.statusCode == needAuthenticateCode){
      Navigator.pushNamed(context as BuildContext, authRouteName).then((value) => onAuthenticated?.call(value));
      return true;
    }
    return false;
  }
}