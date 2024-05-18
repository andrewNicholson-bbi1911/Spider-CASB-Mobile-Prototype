import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_chat_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_auth_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_redmine_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_session.dart';
import 'package:dio/dio.dart';

class SpiderCASBAPI with SpiderCASBAuthApi, SpiderCASBChatApi, SpiderCASBRedmineApi{
  static SpiderCASBSession get session => SpiderCASBSession.instance;

  SpiderCASBAPI();

  Future<dynamic> Ping() async{
    print("pinging...");
    Response<dynamic> request = await SpiderCASBSession.get(
      "ping",
    );

    print("${request.data.runtimeType} ${request.data}");

    return SpiderCASBSession.isRequestSuccessful(request);
  }

}


