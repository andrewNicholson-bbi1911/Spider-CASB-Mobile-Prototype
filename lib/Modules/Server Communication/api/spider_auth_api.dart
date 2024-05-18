import 'package:dio/dio.dart';

import '../spider_session.dart';

mixin SpiderCASBAuthApi{

  static const String BaseAuthUrl = "auth";


  Future<dynamic> LogIn({required String login, required String password}) async{
    Response<dynamic> response = await SpiderCASBSession.post(
      "$BaseAuthUrl/login",
      body: {"login": login, "password": password},
    );

    if(SpiderCASBSession.isRequestSuccessful(response)){
      SpiderCASBSession.SetToken(response.data["token"]);
      SpiderCASBSession.instance.userId = response.data["user_id"];
      SpiderCASBSession.instance.userName = response.data["user_name"];
      return true;
    }else{
      return false;
    }
  }

  Future<bool> Authenticate({required String secretKey, Function(Response<dynamic>, dynamic)? onResponseFailure, dynamic onFailArgs}) async{
    Response<dynamic> response = await SpiderCASBSession.post(
      "$BaseAuthUrl/authentication",
      body: {"secret_key": secretKey},
    );

    if(SpiderCASBSession.isRequestSuccessful(response)){
      return true;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return false;
    }
  }
}