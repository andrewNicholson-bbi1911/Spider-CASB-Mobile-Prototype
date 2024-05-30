import 'package:dio/dio.dart';

import '../spider_session.dart';

mixin SpiderCASBRedmineApi{
  static const String BaseRedmineUrl = "redmine";

  Future<Response<dynamic>?> GetAllIssues({Function(Response<dynamic>, dynamic)? onResponseFailure, dynamic onFailArgs}) async{
    Response<dynamic> response = await SpiderCASBSession.get(
        "$BaseRedmineUrl/issues"
    );
    if(SpiderCASBSession.isRequestSuccessful(response)){
      return response;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return null;
    }
  }

  Future<Response<dynamic>?> GetIssueData({required int issueId, Function(Response<dynamic>, dynamic)? onResponseFailure, dynamic onFailArgs}) async{
    Response<dynamic> response = await SpiderCASBSession.get(
        "$BaseRedmineUrl/issues/data",
        params: {"issue_id" : issueId},
    );
    if(SpiderCASBSession.isRequestSuccessful(response)){
      return response;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return null;
    }
  }

  Future<Response<dynamic>?> UpdateIssueStatus({required int issueId, required int newIssueStatus, Function(Response<dynamic>, dynamic)? onResponseFailure, dynamic onFailArgs}) async{
    Response<dynamic> response = await SpiderCASBSession.put(
      "$BaseRedmineUrl/issues/update_status",
      params: {"issue_id" : issueId},
      body: {"new_issue_status": newIssueStatus},
    );
    if(SpiderCASBSession.isRequestSuccessful(response)){
      return response;
    }else{
      onResponseFailure?.call(response, onFailArgs);
      return null;
    }
  }
}