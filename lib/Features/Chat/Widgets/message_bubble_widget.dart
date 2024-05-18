import 'package:demo_spider_casb_mobile/Features/Chat/Models/message_data.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final MessageData messageData;
  bool get isUser => _isUserCashed;
  final bool _isUserCashed;

  MessageBubble(this.messageData) :
  _isUserCashed = messageData.senderID == SpiderCASBSession.instance.userId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment:
        isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(
              messageData.senderName,
              style: const TextStyle(
                  fontSize: 16,  color: Colors.black87),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(25),
              topLeft: isUser ? const Radius.circular(25) : const Radius.circular(0),
              bottomRight: const Radius.circular(25),
              topRight: isUser ? const Radius.circular(0) : const Radius.circular(25),
            ),
            color: isUser ? Colors.deepPurple : Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    messageData.message,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.deepPurple,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                      messageData.sendingTimeStr,
                      style: TextStyle(
                          color: isUser ? Colors.white60 : const Color.fromARGB(153, 103, 58, 183),
                          fontSize: 10
                      )
                  ),
                ],
              )
            ),
          ),

        ],
      ),
    );
  }
}