import 'dart:ui';

import 'package:flutter/material.dart';

import '_chat_info_widget.dart';

class BaseChatWidget extends ChatInfoWidget{
  BaseChatWidget(super.data);

  @override
  // TODO: implement frameBackgroundColor
  Color get frameBackgroundColor => const Color.fromARGB(255, 246, 246, 246);

}