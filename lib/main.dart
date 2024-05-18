import 'package:demo_spider_casb_mobile/Features/Autentification/authentification_screen.dart';
import 'package:demo_spider_casb_mobile/Features/Chat%20Menu/chat_menu_screen.dart';
import 'package:demo_spider_casb_mobile/Features/Chat/chat_screen.dart';
import 'package:demo_spider_casb_mobile/Features/Log%20In/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SpiderCASBMobileApp());
}

class SpiderCASBMobileApp extends StatelessWidget {

  const SpiderCASBMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',
      // home: ChatterHome(),
      initialRoute: '/login',
      routes: {
        '/login' : (context) => LoginScreen(),
        '/chats' : (context) => ChatsMenuScreen(),
        '/chats/chat' : (context) => ChatScreen(),
        '/authenticate' : (context) => AuthentificationScreen(),
      },
    );
  }
}