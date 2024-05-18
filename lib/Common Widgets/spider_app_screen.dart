import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class SpiderAppScreen extends StatefulWidget{
  final String label;
  final Widget body;

  SpiderAppScreen(this.label, {required this.body});

  @override
  State<StatefulWidget> createState() => _SpiderAppScreenState();

}

class _SpiderAppScreenState extends State<SpiderAppScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      backgroundColor: const Color.fromARGB(230, 255, 255, 255),
      body: widget.body,
    );
  }

}