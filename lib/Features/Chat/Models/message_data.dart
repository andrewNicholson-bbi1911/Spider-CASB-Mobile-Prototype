import 'package:intl/intl.dart';

class MessageData{
  final int senderID;
  final String senderName;
  String get sendingTimeStr {
    final dt = DateTime.fromMillisecondsSinceEpoch(sendingTime).toLocal();
    final now = DateTime.now().toLocal();
    final todayMS = now.millisecondsSinceEpoch;
    final todayDateMS = todayMS - todayMS % 86400000;
    if(sendingTime > todayDateMS)
    {//значит сегодня
      return DateFormat("HH:mm").format(dt);
    }else{
      return DateFormat("d MMMM${dt.year == now.year?'':' y'} HH:mm").format(dt);
    }
  }
  String get shortTimeStr {
    final dt = DateTime.fromMillisecondsSinceEpoch(sendingTime).toLocal();
    final todayMS = DateTime.now().toLocal().millisecondsSinceEpoch;
    final todayDateMS = todayMS - todayMS % 86400000;
    if(sendingTime > todayDateMS)
    {//значит сегодня
      return DateFormat("HH:mm").format(dt);
    }else{
      return DateFormat("MMM d HH:mm").format(dt);
    }
  }
  final int sendingTime;
  final String message;

  MessageData(this.senderID, this.senderName, this.sendingTime, this.message);
  
  MessageData.fromJSON(Map<String, dynamic> json) :
        this.senderID = json["sender_id"]??-1,
        this.senderName = json["sender_name"]??"Chat",
        this.sendingTime = json["sending_time"]??0,
        this.message = json["message"]??"NaN";
}