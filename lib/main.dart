import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stats_bot_app/providers/data_provider.dart';
import 'package:stats_bot_app/screens/home-screen.dart';
import 'package:stats_bot_app/screens/splash-screee.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // showPerformanceOverlay: true,
          title: 'Stats App',
          home: SplashScreen(),
          theme: ThemeData(
              fontFamily: "SF",
              scaffoldBackgroundColor: Colors.grey[100],
              accentColor: Colors.grey[800],
              primaryColorDark: Colors.black,
              primaryColor: Colors.grey[200],
              textTheme: TextTheme(
                headline1: TextStyle(
                  fontFamily: "SF-Rounded",
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
                headline3: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
                headline4: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
                bodyText2: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  fontFamily: "SF-Rounded",
                ),
              )),
        ));
  }
}
