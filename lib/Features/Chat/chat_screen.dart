import 'dart:developer';

import 'package:demo_spider_casb_mobile/Common%20Widgets/spider_app_screen.dart';
import 'package:demo_spider_casb_mobile/Config/config.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/Models/chat_info_data.dart';
import 'package:demo_spider_casb_mobile/Features/Chat/Models/chat_data.dart';
import 'package:demo_spider_casb_mobile/Features/Chat/Widgets/message_bubble_widget.dart';
import 'package:demo_spider_casb_mobile/Mixins/NavigationMixins/BackToLoginMixin.dart';
import 'package:demo_spider_casb_mobile/Mixins/NavigationMixins/GoToAuthenticateMixin.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_chat_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_session.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/loading_widget.dart';

class ChatScreen extends StatefulWidget with BackToLoginScreenMixin, GoToAuthenticateMixin{

  late ChatData chatData;
  bool isChatLoaded = false;

  final SpiderCASBChatApi _api = SpiderCASBAPI();

  ChatScreen({Key? key}) : super(key: key);

  Future<void> LoadChatData(ChatInfoData data, BuildContext context,{ required Function() onChatLoaded, Function()? onChatLoadingError} ) async {
    var response = await _api.GetChatData(
        chatId: data.chatID,
        chatType: data.chatType,
        onResponseFailure: (resp, args) {
          if(!goToAuthenticate(
              resp,
              args,
              onAuthenticated: (_) async => LoadChatData(data, context, onChatLoaded: onChatLoaded, onChatLoadingError: onChatLoadingError))){
            backToLogin(resp, args);
          }
        },
        onFailArgs: context
    );

    if(SpiderCASBSession.isRequestSuccessful(response)){
      var data = response!.data["chat"] as Map<String, dynamic>;
      log("got data:${data.runtimeType}\n$data");
      chatData = ChatData.fromJSON(data);
      log("chats list loaded successfully");
      onChatLoaded.call();
    }else{
      if(onChatLoadingError != null){
        onChatLoadingError.call();
      }
    }
  }

  Future<void> SendMessage(String message, BuildContext context,
      { required Function() onMessageSent, Function()? onMessageSendingError}
      ) async {
    var response = await _api.SendMessage(
        chatId: chatData.chatID,
        chatType: chatData.chatType,
        message: message,
        onResponseFailure: (resp, args) {
          if(!goToAuthenticate(resp, args)){
            backToLogin(resp, args);
          }},
        onFailArgs: context
    );

    if(response != null){
      var data = response.data["chat"] as Map<String, dynamic>;
      chatData = ChatData.fromJSON(data);
      log("message sent successfully");
      onMessageSent.call();
    }else{
      if(onMessageSendingError != null){
        onMessageSendingError.call();
      }
    }
  }

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>{
  static const int chatUpdateTime = 1500;
  final chatMsgTextController = TextEditingController();
  final _scrollController = ScrollController();

  String inputMessageText = "";

  @override
  Widget build(BuildContext context) {
    final chatInfoData = ModalRoute.of(context)!.settings.arguments as ChatInfoData;
    if(!widget.isChatLoaded){
      UpdateChatData(chatInfoData);
    }else{
      Future.delayed(
          const Duration(milliseconds: chatUpdateTime),
          () => UpdateChatData(chatInfoData)
      );
    }

    Widget bodyWidget = !widget.isChatLoaded
        ? SpiderAppLoading()
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MessageList(),
                InputField()
              ],
            )
    );

    return SpiderAppScreen(
        chatInfoData.chatName,
        body: bodyWidget,
        showNavBar: false,
    );
  }

  Widget MessageList(){
    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    var messageAmount = widget.chatData.messages.length;
    var lastSenderId = -1;
    return Expanded(
      child: ListView.builder(
        reverse: true,
          shrinkWrap: true,
          itemCount: messageAmount * 2,
          itemBuilder: (context, index) {
            var senderIndex = messageAmount - 1 - index~/2;
            if(senderIndex - 1 <= 0){
              lastSenderId = -1;
            }else{
              lastSenderId = widget.chatData.messages[senderIndex-1].senderID;
            }
            var currentSenderID = widget.chatData.messages[senderIndex].senderID;
            if(index%2 == 1){
              return SizedBox(height: lastSenderId == currentSenderID ? 0 : 6);
            }else{

              var messageBubble = MessageBubble(widget.chatData.messages[senderIndex], lastSenderId);
              return messageBubble;
            }
          }),
    );
  }

  Widget InputField(){
    return Container(
      padding: EdgeInsets.symmetric(vertical:10,horizontal: 10),
      decoration: Config.kMessageContainerDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              elevation:5,
              child: Padding(
                padding: const EdgeInsets.only(left:8.0,top:2,bottom: 2),
                child: TextField(
                  onChanged: (value) {
                    inputMessageText = value;
                  },
                  controller: chatMsgTextController,
                  decoration: Config.kMessageTextFieldDecoration,
                  minLines: 1,
                  maxLines: 10,

                ),
              ),
            ),
          ),
          MaterialButton(
              shape: CircleBorder(),
              color: Colors.deepPurpleAccent,
              onPressed:
              () {
                if(inputMessageText.isNotEmpty){
                  chatMsgTextController.clear();
                  widget.SendMessage(
                    inputMessageText,
                    context,
                    onMessageSent: () => setState(() {
                      chatMsgTextController.clear();
                      widget.isChatLoaded = true;
                    }));
                }
              },
              child:const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.send,color: Colors.white,),
              )
            // Text(
            //   'Send',
            //   style: kSendButtonTextStyle,
            // ),
          ),
        ],
      ),
    );
  }

  Future<void> UpdateChatData(ChatInfoData chatInfoData) async {
    widget.LoadChatData(
        chatInfoData,
        context,
        onChatLoaded: () => setState(
                () {
                  widget.isChatLoaded = true;
                  log("chat ${chatInfoData.chatID} loaded sucessfully");
                })
    );
  }



}