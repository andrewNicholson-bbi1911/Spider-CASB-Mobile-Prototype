
import 'dart:developer';
import 'dart:ui';

import 'package:demo_spider_casb_mobile/Config/config.dart';
import 'package:demo_spider_casb_mobile/Features/Issue/Models/issue_data.dart';
import 'package:demo_spider_casb_mobile/Features/Issues%20Menu/Models/short_issue_data.dart';
import 'package:demo_spider_casb_mobile/Mixins/NavigationMixins/BackToLoginMixin.dart';
import 'package:demo_spider_casb_mobile/Mixins/NavigationMixins/GoToAuthenticateMixin.dart';
import 'package:demo_spider_casb_mobile/Modules/Server%20Communication/api/spider_redmine_api.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Common Widgets/spider_app_screen.dart';
import '../../Modules/Server Communication/spider_api.dart';
import '../../Modules/Server Communication/spider_session.dart';

class IssueDataScreen extends StatefulWidget with BackToLoginScreenMixin, GoToAuthenticateMixin{
  late IssueData issueData;

  bool isDataLoaded = false;
  final SpiderCASBRedmineApi _api = SpiderCASBAPI();

  Future<void> LoadIssueData(ShortIssueData data, BuildContext context, { required Function() onIssueLoaded, Function()? onIssueLoadingError} ) async {
    var response = await _api.GetIssueData(
        issueId: data.issueID,
        onResponseFailure: (resp, args) {
          if(!goToAuthenticate(
              resp,
              args,
              onAuthenticated: (_) async => LoadIssueData(data, context, onIssueLoaded: onIssueLoaded, onIssueLoadingError: onIssueLoadingError))){
            backToLogin(resp, args);
          }
        },
        onFailArgs: context
    );

    if(SpiderCASBSession.isRequestSuccessful(response)){
      var data = response!.data["issue"] as Map<String, dynamic>;
      log("got data:${data.runtimeType}\n$data");
      issueData = IssueData.fromJSON(data);
      log("issue data loaded successfully");
      onIssueLoaded.call();
    }else{
      if(onIssueLoadingError != null){
        onIssueLoadingError.call();
      }
    }
  }

  Future<void> UpdateStatus(int newStatus, BuildContext context, { required Function() onIssueStatusUpdated, Function()? onIssueStatusUpdateError}) async{
    var response = await _api.UpdateIssueStatus(
        issueId: issueData.id,
        newIssueStatus: newStatus,
        onResponseFailure: (resp, args) {
          if(!goToAuthenticate(
              resp,
              args,
              onAuthenticated: (_) async => UpdateStatus(newStatus, context, onIssueStatusUpdated: onIssueStatusUpdated, onIssueStatusUpdateError: onIssueStatusUpdateError))){
            backToLogin(resp, args);
          }
        },
        onFailArgs: context
    );

    if(SpiderCASBSession.isRequestSuccessful(response)){
      log("issue status updated successfully");
      onIssueStatusUpdated.call();
    }else{
      if(onIssueStatusUpdateError != null){
        onIssueStatusUpdateError.call();
      }
    }
  }


  @override
  State<StatefulWidget> createState() => _IssueDataScreenState();
}


class _IssueDataScreenState extends State<IssueDataScreen> {

  _IssueDataScreenState();

  @override
  Widget build(BuildContext context) {
    final chatInfoData = ModalRoute.of(context)!.settings.arguments as ShortIssueData;
    if(!widget.isDataLoaded){
      UpdateIssueData(chatInfoData);
    }


    return SpiderAppScreen(
      "Issue info",
      body:
      SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: infoData(chatInfoData, context),
        ),
      ),
      showNavBar: false,
    );
  }

  Widget infoData(ShortIssueData data, BuildContext context) {
    return
    Container(
      padding: const EdgeInsets.all(16),
      child:  Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 2),
                    spreadRadius: 1,
                    blurRadius: 3
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Color.fromARGB(255, 255, 240, 201)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.issueData.label,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28
                ),
              ),
              const SizedBox(height: 2,),
              Text(
                widget.issueData.urgencyName,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Config.urgencyColors[widget.issueData.urgency]
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                widget.issueData.statusName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2,),
              Text(
                "Due To: ${widget.issueData.dueDate?.replaceAll("-", ".")}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2,),
              const Text(
                "Description:",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2,),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: const BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    color: Colors.white70,
                  ),
                  child: Text(
                    widget.issueData.description.isEmpty ? "no description" : widget.issueData.description,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              const SizedBox(height: 2,),
              const Expanded(child: SizedBox(width: 2,)),
              UpdateNextStatusButton(data, context)??const SizedBox(height: 1,),
              UpdatePreviousStatusButton(data, context)??const SizedBox(height: 1,),

            ],
          ),
        )
    );
  }

  Widget? UpdateNextStatusButton(ShortIssueData shortData, BuildContext context){
    int nextStatus =  widget.issueData.status + 1;
    if(nextStatus < IssueData.statusNames.length - 1){
      return TextButton(
          onPressed: () => widget.UpdateStatus(
              widget.issueData.status + 1,
              context,
              onIssueStatusUpdated: () => UpdateIssueData(shortData)
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              borderRadius:  BorderRadius.all(Radius.circular(8)),
              color: Colors.deepPurpleAccent,
            ),
            child: Text(
              "Update status to '${IssueData.statusNames[nextStatus]}'",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
      );
    }
  }

  Widget? UpdatePreviousStatusButton(ShortIssueData shortData, BuildContext context){
    int prevStatus =  widget.issueData.status - 1;
    if(prevStatus >= 1){
      return TextButton(
          onPressed: () => widget.UpdateStatus(
              prevStatus,
              context,
              onIssueStatusUpdated: () => UpdateIssueData(shortData)
          ),
        child: Text(
          "Update status to '${IssueData.statusNames[prevStatus]}'",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600
          ),
        ),
      );
    }
  }

  Future<void> UpdateIssueData(ShortIssueData shortIssueData) async {
    widget.LoadIssueData(
        shortIssueData,
        context,
        onIssueLoaded: () => setState(
                () {
              widget.isDataLoaded = true;
              log("issue ${shortIssueData.issueID} loaded successfully");
            })
    );
  }
}