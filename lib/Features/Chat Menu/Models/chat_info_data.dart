import 'package:demo_spider_casb_mobile/Features/Chat/Models/message_data.dart';

class ChatInfoData{
  final String chatName;
  final String chatType;
  final int chatID;
  MessageData lastMessage;

  ChatInfoData(this.chatName, this.chatType, this.chatID, this.lastMessage);

  ChatInfoData.fromJSON(Map<String, dynamic> json) :
        this.chatID = json["chat_id"],
        this.chatType = json["chat_type"],
        this.chatName = json["chat_label"],
        this.lastMessage = MessageData.fromJSON((json["last_message"]??{"NaN":"NaN"}) as Map<String, dynamic>);
}