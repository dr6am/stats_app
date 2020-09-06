import 'package:intl/intl.dart';

class DailyData {
  int newUsers;
  int count;
  DateTime date;
  DailyData({
    this.newUsers,
    this.count,
    String date,
  }){
    var inputFormat = DateFormat("dd/MM/yyyy");
    var date1 = inputFormat.parse(date);

    var outputFormat = DateFormat("yyyy-MM-dd");
    this.date =  DateTime.parse(outputFormat.parse("$date1").toString()); //
    // this.date =date);
  }
  DailyData.fromJson(Map<String,dynamic> json){
    this.newUsers = json["newUsers"];
    this.count = json["count"];
    var inputFormat = DateFormat("dd/MM/yyyy");
    var date1 = inputFormat.parse(json["date"]);

    var outputFormat = DateFormat("yyyy-MM-dd");
    this.date =  DateTime.parse(outputFormat.parse("$date1").toString());
  }
}
