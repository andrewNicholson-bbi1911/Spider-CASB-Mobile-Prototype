import 'dart:developer';

import 'package:demo_spider_casb_mobile/Features/Chat/Models/message_data.dart';

class ChatData{
  final int chatID;
  final String chatType;
  //List<int> chatUsers;
  List<MessageData> messages;

  ChatData(this.chatID, this.chatType, this.messages);

  ChatData.fromJSON(Map<String, dynamic> json) :
        this.chatID = json["chat_id"],
        this.chatType = json["chat_type"],
        //this.chatUsers = json["chat_users"] as List<int>,
        this.messages = <MessageData>[]
  {
    List<dynamic> rawMessages = json["messages_list"];
    log("loading ${rawMessages.length} message");

    rawMessages.forEach((message_raw_data) {
      log("got message>>>");
      log(message_raw_data.toString());
      Map<String, dynamic> message_json = message_raw_data;
      messages.add(MessageData.fromJSON(message_json));
    });
    log(" messageList loaded");

  }
}