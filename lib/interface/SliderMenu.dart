import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_app/Handler/ProjectHandler.dart';
import 'package:split_app/interface/StartupMenu.dart';
import 'package:split_app/modele/project.dart';

class SliderMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new SliderMenuPage();
}

class SliderMenuPage extends State<SliderMenu> {
  List<Widget> menuItems;

  @override
  void initState() {
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

    updateSideMenuPanel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.zero,
          children: menuItems,
        ),
      ),
      body: new StartupMenu(),
    );
  }

  Future updateSideMenuPanel() async {
    String jsonSaveContent =
        await ProjectHandler.getJsonSaveContentFromSharedPreferences();
    List<Project> projects = ProjectHandler.getSavedProject(jsonSaveContent);

    parseProjectInWidgetMenu(projects);
    setState(() {});
  }

  void parseProjectInWidgetMenu(List<Project> projects) {
    if (projects.isEmpty) {
      menuItems.add(
        ListTile(
          title: Text(
            "No existing project",
            style: new TextStyle(
              fontFamily: "sans-sérif",
              fontWeight: FontWeight.w100,
              fontSize: 20.0,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      );
      return;
    }

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
}
