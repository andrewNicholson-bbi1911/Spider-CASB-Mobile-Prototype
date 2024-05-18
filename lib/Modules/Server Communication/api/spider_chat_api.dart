import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_api.dart';
import 'package:dio/dio.dart';

import '../spider_session.dart';

mixin SpiderCASBChatApi{

  static const String BaseChatUrl = "chat";

  Future<Response<dynamic>?> GetAllChats({Function(Response<dynamic>, dynamic)? onResponseFailure, dynamic onFailArgs}) async{
    Response<dynamic> response = await SpiderCASBSession.get(
      "$BaseChatUrl/all"
    );
    if(SpiderCASBSession.isRequestSuccessful(response)){
      return response;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return null;
    }
  }

  Future<Response<dynamic>?> GetChatData({ required int chatId, required String chatType, Function(Response<dynamic>, dynamic)? onResponseFailure, dynamic onFailArgs} ) async{
    Response<dynamic> response = await SpiderCASBSession.get(
        "$BaseChatUrl/chat_data",
      params: {"chat_id": chatId, "chat_type": chatType}
    );
    if(SpiderCASBSession.isRequestSuccessful(response)){
      return response;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return null;
    }
  }

  Future<Response<dynamic>?> SendMessage({
    required int chatId,
    required String chatType,
    required String message,
    Function(Response<dynamic>, dynamic)? onResponseFailure,
    dynamic onFailArgs}
    ) async {

    Response<dynamic> response = await SpiderCASBSession.post(
        "$BaseChatUrl/send_message",
        params: {"chat_id": chatId, "chat_type": chatType},
        body: {"message": message}
    );

    if(SpiderCASBSession.isRequestSuccessful(response)){
      return response;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return null;
    }
  }
}