import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_app/Constant.dart';
import 'package:split_app/modele/project.dart';

class StartupMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StartupMenuPage();
}

class StartupMenuPage extends State<StartupMenu> {
  List<Widget> menuItems;

  @override
  Future initState() async {
    String jsonSaveContent = await getJsonSaveContentFromSharedPreferences();
    List<Project> projects = await getSavedProject(jsonSaveContent);
    parseProjectInWidgetMenu(projects);

    super.initState();
  }

  void parseProjectInWidgetMenu(List<Project> projects) {
    for (Project project in projects) {
      menuItems.add(
        ListTile(
          title: Text(project.name),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  Future<String> getJsonSaveContentFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(Constant.SP_KEY_SAVES);
  }

  Future<List<Project>> getSavedProject(String jsonContent) async {
    List<Project> projects = new List<Project>();
    var jsonProjects = json.decode(jsonContent);

    for (String json in jsonProjects) {
      Project project = new Project();
      project.fromJson(json);
      projects.add(project);
    }

    return projects;
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
