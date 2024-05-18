import 'dart:developer';

import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/Models/chat_info_data.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/Widgets/_chat_info_widget.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_chat_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../Common Widgets/loading_widget.dart';
import '../../Common Widgets/spider_app_screen.dart';

class ChatsMenuScreen extends StatefulWidget{
  List<ChatInfoData> chats_info = <ChatInfoData>[];
  bool isDataLoaded = false;
  final SpiderCASBChatApi _api = SpiderCASBAPI();


  Future<void> LoadChatsInfo({
    required Function onChatsLoaded,
    Function? onLoadingError}) async{
    log("start loading chats");
    _api.GetAllChats().then((response) {
      if(response == null){
        log("chat loading error");
        if(onLoadingError!=null){
          onLoadingError.call();
        }else{
          LoadChatsInfo(onChatsLoaded: onChatsLoaded);
        }
      }else{
        var rawChatData = response.data["chats"];
        chats_info = <ChatInfoData>[];
        rawChatData.forEach((chat_info_json) {
          chats_info.add(ChatInfoData.fromJSON(chat_info_json as Map<String, dynamic>));
        });
        log("chats list loaded successfully");
        onChatsLoaded();
      }
    });
  }

  @override
  State<StatefulWidget> createState() => _ChatsMenuScreenState();
}


class _ChatsMenuScreenState extends State<ChatsMenuScreen>{

  _ChatsMenuScreenState();

  @override
  Widget build(BuildContext context) {
    if(!(widget.isDataLoaded)) {
      widget.LoadChatsInfo(
          onChatsLoaded: () {
            log("chats realy loaded successfully");
            setState(() {
              widget.isDataLoaded = true;
            });
          }
      );
    }else{
      Future.delayed(
          const Duration(seconds: 6),
          () => widget.LoadChatsInfo(
              onChatsLoaded: () {
                log("chats realy loaded successfully");
                setState(() {
                  widget.isDataLoaded = true;
                });
              }
          )
      );
    }

    Widget bodyWidget = widget.isDataLoaded ? chatsList() : SpiderAppLoading();

    return SpiderAppScreen(
      "Chats",
      body: Container(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: bodyWidget,
      ),
    );
  }

  Widget chatsList(){
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: widget.chats_info.length * 2,
      itemBuilder: (context, index) {
        if(index%2 != 0){
          return ChatInfoWidget.fromData(widget.chats_info[index~/2]);
        }else{
          return const SizedBox(height: 8);
        }
      },
      clipBehavior: Clip.antiAlias,
    );
  }

}
