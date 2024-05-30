import 'package:avatar_generator/avatar_generator.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/Models/chat_info_data.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/Widgets/base_chat_widget.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/Widgets/secret_chat_widget.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/chat_menu_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ChatInfoWidget extends StatelessWidget{
  final ChatInfoData data;

  Color get frameBackgroundColor;

  ChatInfoWidget(this.data);

  factory ChatInfoWidget.fromData(ChatInfoData data){
    if(data.chatType == "Secret"){

      return SecretChatWidget(data);
    }else{
      return BaseChatWidget(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/chats/chat', arguments: data);
          },
        child: ChatInfoFrame(context)
    );
  }

  Widget ChatInfoFrame(BuildContext context){

    bool isSecretChat = data.chatType == "Secret";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      height: 80,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(1, 2),
            spreadRadius: 1,
            blurRadius: 3
          )
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: frameBackgroundColor
      ),
      child:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: isSecretChat ? Color.fromARGB(250, 111, 2, 161):  Color.fromARGB(236, 210, 111, 255) ,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: AvatarGenerator(
                    seed: "${data.chatID}_${data.chatType}_2",
                    colors: isSecretChat
                        ? const [Color.fromARGB(255, 230, 192, 246), Color.fromARGB(255, 209, 133, 246)]
                        : const [Color.fromARGB(255, 230, 230, 250), Color.fromARGB(255, 231, 196, 248)],
                    mirroredHorizontally: false,
                    mirroredVertically: false,
                    horizontalTileCount: 3,
                    verticalTileCount: 3,
                  )
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.chatName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700
                        ),
                        maxLines: 1,
                        softWrap: true,
                      ),
                      const SizedBox(height: 4,),
                      Expanded(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.lastMessage.senderName}:",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                  ),
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                                const SizedBox(width: 4,),
                                Expanded(
                                  child: Text(
                                  data.lastMessage.message,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                                )

                              ]
                          )
                      )
                    ],
                  )
              ),
              const SizedBox(width: 4,),
              SizedBox(
                width: 46,
                child: Text(
                  data.lastMessage.shortTimeStr,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )

    );
  }
}