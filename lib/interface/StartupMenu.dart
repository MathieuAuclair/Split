import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_app/Constant.dart';

class StartupMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StartupMenuPage();
}

class StartupMenuPage extends State<StartupMenu> {
  List<Widget> menuItems;
  String jsonSaveContent;

  @override
  Future initState() async {

    jsonSaveContent = await getJsonSaveContentFromSharedPreferences();

    super.initState();
  }

  Future<String> getJsonSaveContentFromSharedPreferences()async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Constant.SP_KEY_SAVES);
  }

  @override
  Widget build(BuildContext context) {
    menuItems = [
      DrawerHeader(
        child: Text(
          'SPLIT  |  MENU',
          style: new TextStyle(
            fontFamily: "sans-sérif",
            fontWeight: FontWeight.w100,
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
      ),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "SPLIT",
          style: new TextStyle(
            fontFamily: "sans-sérif",
            fontWeight: FontWeight.w100,
            fontSize: 25.0,
          ),
        ),
      ),
      drawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: menuItems,
        ),
      ),
      body: new Text("sample test"),
    );
  }
}
