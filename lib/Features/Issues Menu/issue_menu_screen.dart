import 'dart:developer';

import 'package:demo_spider_casb_mobile/Features/Issues%20Menu/Models/short_issue_data.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_redmine_api.dart';
import 'package:flutter/cupertino.dart';

import '../../Common Widgets/spider_app_screen.dart';
import '../../Modules/Server Communication/spider_api.dart';
import 'Widgets/short_issue_info_widget.dart';

class IssuesMenuScreen extends StatefulWidget{
  List<ShortIssueData> issues_info = <ShortIssueData>[];
  bool isDataLoaded = false;
  final SpiderCASBRedmineApi _api = SpiderCASBAPI();

  Future<void> LoadIssuesInfo({
    required Function onIssuesLoaded,
    Function? onLoadingError}) async{
    log("start loading issues");
    _api.GetAllIssues().then((response) {
      if(response == null){
        log("issues loading error");
        if(onLoadingError!=null){
          onLoadingError.call();
        }else{
          LoadIssuesInfo(onIssuesLoaded: onIssuesLoaded);
        }
      }else{
        var rawChatData = response.data["issues"];
        issues_info = <ShortIssueData>[];
        rawChatData.forEach((issue_info_json) {
          issues_info.add(ShortIssueData.fromJSON(issue_info_json as Map<String, dynamic>));
        });
        log("issues list loaded successfully");
        onIssuesLoaded();
      }
    });
  }

  @override
  State<StatefulWidget> createState() => _IssuesMenuScreenState();
}


class _IssuesMenuScreenState extends State<IssuesMenuScreen>{

  _IssuesMenuScreenState();

  @override
  Widget build(BuildContext context) {
    if(!(widget.isDataLoaded)) {
      UpdateIssueList();
    }else{
      Future.delayed(
          const Duration(seconds: 5),
              () => widget.LoadIssuesInfo(
              onIssuesLoaded: () {
                log("issues realy loaded successfully");
                setState(() {
                  widget.isDataLoaded = true;
                });
              }
          )
      );
    }

    return SpiderAppScreen(
      "Redmine Issues",
      body: Container(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: issuesList(),
      ),
      showNavBar: true,
    );
  }

  Widget issuesList(){
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: widget.issues_info.length * 2,
      itemBuilder: (context, index) {
        if(index%2 != 0){
          return IssueInfoWidget.fromData(widget.issues_info[index~/2], UpdateIssueList);
        }else{
          return const SizedBox(height: 8);
        }
      },
      clipBehavior: Clip.antiAlias,
    );
  }

  Future<void> UpdateIssueList() async {
    await widget.LoadIssuesInfo(
        onIssuesLoaded: () {
          log("issues realy loaded successfully");
          setState(() {
            widget.isDataLoaded = true;
          });
        }
    );
  }

}