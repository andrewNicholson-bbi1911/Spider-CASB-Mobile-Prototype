import 'package:demo_spider_casb_mobile/Common%20Widgets/spider_app_screen.dart';
import 'package:demo_spider_casb_mobile/Mixins/NavigationMixins/BackToLoginMixin.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_auth_api.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/spider_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/custom_button.dart';
import '../../Common Widgets/custom_text_input.dart';

class AuthentificationScreen extends StatefulWidget with BackToLoginScreenMixin {
  @override
  _AuthentificationScreenState createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {
  late String secretKey;
  final SpiderCASBAuthApi _api = SpiderCASBAPI();

  @override
  Widget build(BuildContext context) {
    return SpiderAppScreen(
      "Аутентификация",
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
                    'Spider CASB Authentication',
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
                  hintText: 'Secret key',
                  leading: Icons.key,
                  obscure: true,
                  userTyped: (val) {
                    secretKey = val;
                  },
                  //textAlignment: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Hero(
                  tag: 'authenticationButton',
                  child: CustomButton(
                    text: 'send key',
                    accentColor: Colors.white,
                    mainColor: Colors.deepPurple,
                    onPress: () async {
                      var res = await _api.Authenticate(
                          secretKey: secretKey,
                        onResponseFailure: widget.backToLogin,
                        onFailArgs: context
                      );
                      if(res){
                        Navigator.pop(context);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      showNavBar: false,
    );
  }
}