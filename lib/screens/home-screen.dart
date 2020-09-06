import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stats_bot_app/models/daily_model.dart';
import 'package:stats_bot_app/providers/data_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataProvider data = Provider.of<DataProvider>(context);
    String totalUsers = data.totalUsersSting;
    print("build");
    return Scaffold(
        body: SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                        title: const Text('Choose server'),
                        message: const Text('Your options are: '),
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('firstbottele'),
                            onPressed: () {
                              data.setServer(
                                  "https://firstbottele.herokuapp.com/");
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: const Text('mainpartofbotpenis'),
                            onPressed: () {
                              data.setServer(
                                  "https://mainpartofbotpenis.herokuapp.com/");
                              Navigator.pop(context);
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          isDefaultAction: true,
                          onPressed: () {},
                        )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Server:",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Container(
                        child: Text(
                          "${data.serverName}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Column(
              children: <Widget>[
                Text(
                  "Total users count",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .apply(fontSizeDelta: -5),
                ),
                Text(
                  "💁‍♂️‍$totalUsers",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .apply(fontSizeDelta: 15),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
                height: MediaQuery.of(context).size.width * .6,
                width: MediaQuery.of(context).size.width * .9,
                child: buildChart(context)),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Text("Median"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Text(
                            "new users",
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("~${data.median_newUsers.toStringAsFixed(1)}"),
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: <Widget>[
                          Text("used times",
                              style: Theme.of(context).textTheme.caption),
                          SizedBox(
                            height: 10,
                          ),
                          Text("~${data.median_usedCount.toStringAsFixed(1)}"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    ));
  }

  Widget buildChart(BuildContext context) {
    DataProvider data = Provider.of<DataProvider>(context);

    return new charts.TimeSeriesChart(
      _createSampleData(data.dailyDataList),
      animate: true,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  static List<charts.Series<DailyData, DateTime>> _createSampleData(
      List<DailyData> data) {
    data.sort((a, b) => a.date.compareTo(b.date));
    return [
      new charts.Series<DailyData, DateTime>(
        id: 'count',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (DailyData sales, _) => sales.date,
        measureFn: (DailyData sales, _) => sales.count,
        data: data,
      ),
      new charts.Series<DailyData, DateTime>(
        id: 'newUsers',
        colorFn: (_, __) => charts.MaterialPalette.black,
        domainFn: (DailyData sales, _) => sales.date,
        measureFn: (DailyData sales, _) => sales.newUsers,
        data: data,
      )
    ];
  }

  Widget columnCell(element, context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(element.date.toLocal());
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(16),
        height: 50,
        width: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatted,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              element.count.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              element.newUsers.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
