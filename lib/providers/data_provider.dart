import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:stats_bot_app/models/daily_model.dart';

class DataProvider extends ChangeNotifier {
  String _serverName = "https://firstbottele.herokuapp.com/";

  int _totalUsers = 0;
  List<DailyData> dailyDataList = List<DailyData>();

  var _f = new NumberFormat("#,###", "en_US");

  String get serverName => _serverName.substring(8, _serverName.length - 15);
  String get totalUsersSting => this._f.format(_totalUsers);
  double get median_newUsers =>
      dailyDataList.fold(0.0, (value, element) => value += element.newUsers) /
      dailyDataList.length;

  double get median_usedCount =>
      dailyDataList.fold(0.0, (value, element) => value += element.count) /
      dailyDataList.length;

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _serverName =
        prefs.getString('server_name') ?? "https://firstbottele.herokuapp.com/";
    final url = '${_serverName}stats';
    final dailyUrl = '${_serverName}daily';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      this._totalUsers = jsonResponse["count"];

      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');

      notifyListeners();
    }
    var dailyResponse = await http.get(dailyUrl);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(dailyResponse.body);
      jsonResponse.forEach((e) {
        dailyDataList.add(DailyData.fromJson(e));
      });
      print(dailyDataList);
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');

      notifyListeners();
    }
  }

  void setServer(String newHost) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('server_name', newHost);
    this.loadData();
    _serverName = newHost;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
// class ServerNames {
//   String first = "";
//   String second = "";
// }
