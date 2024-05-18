import 'dart:ui';

import 'package:flutter/material.dart';

import '_chat_info_widget.dart';

class SecretChatWidget extends ChatInfoWidget{
  SecretChatWidget(super.data);

  @override
  // TODO: implement frameBackgroundColor
  Color get frameBackgroundColor => Color.lerp(Colors.deepPurple, Colors.white, 0.8)!;

}