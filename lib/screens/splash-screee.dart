import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stats_bot_app/providers/data_provider.dart';

import 'home-screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataProvider data = Provider.of<DataProvider>(context,listen:false);
    Future.delayed(const Duration(milliseconds: 1500), () {
      data.loadData();
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>HomeScreen(),
      ));
    });
    return Scaffold(
      body: Center(
       child: Theme
              .of(context)
              .platform == TargetPlatform.iOS ?
          CupertinoActivityIndicator() : CircularProgressIndicator()
      ),
    );
  }
}
