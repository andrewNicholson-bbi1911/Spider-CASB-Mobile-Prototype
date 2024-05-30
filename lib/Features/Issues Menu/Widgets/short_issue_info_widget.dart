import 'package:demo_spider_casb_mobile/Features/Issues%20Menu/Models/short_issue_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Config/config.dart';

class IssueInfoWidget extends StatelessWidget{
  final ShortIssueData data;
  Function onTaskReturn;

  IssueInfoWidget(this.data, {required this.onTaskReturn});

  factory IssueInfoWidget.fromData(ShortIssueData data, Function onTaskReturn){
    return IssueInfoWidget(data, onTaskReturn: onTaskReturn);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/issues/issue', arguments: data).then((val) => onTaskReturn.call);
        },
        child: ChatInfoFrame(context)
    );
  }

  Widget ChatInfoFrame(BuildContext context){

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: Color.fromARGB(255, 255, 240, 201)
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                data.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              data.urgencyName,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Config.urgencyColors[data.urgency],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              data.statusName,
              style: const TextStyle(
                  fontSize: 18
              ),
            ),
          ],

        )

    );
  }
}