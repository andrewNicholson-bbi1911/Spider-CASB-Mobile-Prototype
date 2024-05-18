//import 'package:edge_alert/edge_alert.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/custom_button.dart';
import '../../Common Widgets/custom_text_input.dart';
import '../../Modules/Server Communication/api/spider_auth_api.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  late String login;
  late String password;
  final SpiderCASBAuthApi _api = SpiderCASBAPI();
  bool loggingin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(// backgroundColor: Colors.transparent,
      body: Container(
          height: MediaQuery.of(context).size.height,
            //margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(
                      tag: 'heroicon',
                      child: Icon(
                        Icons.shield,
                        size: 120,
                        color: Colors.deepPurple[900],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Hero(
                        tag: 'HeroTitle',
                        child: Text(
                            'Spider CASB',
                            style: TextStyle(
                                color: Colors.deepPurple[900],
                                //fontFamily: 'Poppins',
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                        ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    CustomTextInput(
                        hintText: 'Login',
                        leading: Icons.mail,
                        obscure: false,
                        keyboard: TextInputType.emailAddress,
                        userTyped: (val) {
                          login = val;
                        },
                    ),
                    const SizedBox(
                        height: 0,
                    ),
                    CustomTextInput(
                        hintText: 'Password',
                        leading: Icons.lock,
                        obscure: true,
                        userTyped: (val) {
                            password = val;
                        },
                    ),
                    const SizedBox(
                        height: 30,
                    ),
                    Hero(
                        tag: 'loginbutton',
                        child: CustomButton(
                            text: 'login',
                            accentColor: Colors.white,
                            mainColor: Colors.deepPurple,
                            onPress: () async {
                                if (password.length <= 8 || login == "") {
                                    //логин и пароль не валидны
                                }else{
                                    setState(() {
                                        loggingin = true;
                                    });

                                    try{
                                        final signInSuccessful = await _api.LogIn(login: login, password: password);

                                        if(signInSuccessful){
                                            print("sign in successful: ${signInSuccessful}\nlogin: ${login} || password: ${password}");
                                            if(Navigator.canPop(context)){
                                              Navigator.pop(context);
                                            }else{
                                              Navigator.pushNamed(context, '/chats');
                                            }
                                        }else{

                                        }
                                    }catch(_){
                                        setState(() {
                                            loggingin = false;
                                        });
                                        print(_);
                                        /*
                                        EdgeAlert.show(context,
                                            title: 'Login Failed',
                                            description: e.toString(),
                                            gravity: EdgeAlert.BOTTOM,
                                            icon: Icons.error,
                                            backgroundColor: Colors.deepPurple[900]);
                                         */
                                    }
                                }
                              // Navigator.pushReplacementNamed(context, '/chat');
                            },
                        ),
                    )
                ],
              ),
            ),
        ),

    );
  }
}