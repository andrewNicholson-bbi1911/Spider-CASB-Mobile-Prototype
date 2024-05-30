class IssueData {
  final int id;
  final String label;
  final int urgency;
  final int status;
  final String? dueDate;
  final String description;

  String get statusName {
    return statusNames[status];
  }
  String get urgencyName {
    return urgencyNames[urgency];
  }
  static const List<String> urgencyNames = ["?", "Low", "Medium", "Urgent", "Most Urgent!"];
  static const List<String> statusNames = ["?", "Awaiting", "In Progress", "On Check", "Done"];

  IssueData({required this.id, required this.label, required this.urgency, required this.status, required this.description, this.dueDate});

  IssueData.fromJSON(Map<String, dynamic> json) :
        this.id = json["id"],
        this.label = json["subject"],
        this.urgency = (json["priority"] as Map<String, dynamic>)["id"],
        this.status = (json["status"] as Map<String, dynamic>)["id"],
        this.dueDate = json["due_date"]??"no due date",
        this.description = json["description"];
}