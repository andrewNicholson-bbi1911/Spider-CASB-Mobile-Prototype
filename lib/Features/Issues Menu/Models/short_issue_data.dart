class ShortIssueData {
  final int issueID;
  final String label;
  final int urgency;
  final int status;
  String get statusName {
    return statusNames[status];
  }
  String get urgencyName {
    return urgencyNames[urgency];
  }
  static const List<String> urgencyNames = ["?", "Low", "Medium", "Urgent", "Most Urgent!"];
  static const List<String> statusNames = ["?", "Awaiting", "In Progress", "On Check", "Done"];

  ShortIssueData({required this.issueID, required this.label, required this.urgency, required this.status});

  ShortIssueData.fromJSON(Map<String, dynamic> json) :
      this.issueID = json["id"],
      this.label = json["subject"],
      this.urgency = (json["priority"] as Map<String, dynamic>)["id"],
      this.status = (json["status"] as Map<String, dynamic>)["id"];
}