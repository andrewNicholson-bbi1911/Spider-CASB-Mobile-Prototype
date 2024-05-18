import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SpiderAppLoading extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: const SizedBox(
          width: 150,
          height: 150,
          child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [Colors.deepPurple],
          ),
        )
    );
  }

}