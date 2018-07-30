import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:split_app/Handler/ProjectHandler.dart';

import 'package:split_app/modele/project.dart';

class StartupMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StartupMenuPage();
}

class StartupMenuPage extends State<StartupMenu> {
  final userTextController = TextEditingController();
  final projectTextController = TextEditingController();

  List<Widget> menuItems;
  List<Widget> usersChips = [];

  @override
  void initState() {
    Future<String> jsonSaveContent =
        ProjectHandler.getJsonSaveContentFromSharedPreferences();
    Future<List<Project>> projects =
        ProjectHandler.getSavedProject(jsonSaveContent);
    parseProjectInWidgetMenu(projects);

    super.initState();
  }

  Future parseProjectInWidgetMenu(Future<List<Project>> futureProjects) async {
    List<Project> projects = await futureProjects;

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

  @override
  void dispose() {
    userTextController.dispose();
    projectTextController.dispose();
    super.dispose();
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
      body: new SingleChildScrollView(
        child: new Container(
          width: MediaQuery.of(context).size.width,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  bottom: MediaQuery.of(context).size.height * 0.07,
                ),
                child: new Text(
                  "NEW PROJECT",
                  style: new TextStyle(
                    fontFamily: "sans-sérif",
                    fontWeight: FontWeight.w100,
                    fontSize: 25.0,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.1,
                  left: MediaQuery.of(context).size.width * 0.1,
                ),
                child: new TextFormField(
                  keyboardType: TextInputType.text,
                  autovalidate: true,
                  controller: projectTextController,
                  decoration: InputDecoration(
                    labelText: 'project\'s name',
                    hintText: null,
                    border: new UnderlineInputBorder(),
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: usersChips,
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(bottom: 20.0),
                child: new RaisedButton(
                  onPressed: _neverSatisfied,
                  child: new Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    child: new Text(
                      "Add new user",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "sans-sérif",
                        fontWeight: FontWeight.w100,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                margin: new EdgeInsets.only(bottom: 20.0),
                child: new RaisedButton(
                  onPressed: null,
                  child: new Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.025,
                    ),
                    child: new Text(
                      "Create new project",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontFamily: "sans-sérif",
                        fontWeight: FontWeight.w100,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> _neverSatisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Add new user'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.1,
                    left: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: new TextFormField(
                    keyboardType: TextInputType.text,
                    autovalidate: true,
                    controller: userTextController,
                    decoration: InputDecoration(
                      labelText: 'users\'s name',
                      hintText: null,
                      border: new UnderlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                userTextController.clear();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Confirm'),
              onPressed: () {
                usersChips.add(
                  new Container(
                    margin: new EdgeInsets.all(5.0),
                    child: new Chip(
                      avatar: new CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: new Icon(Icons.account_circle),
                      ),
                      label: new Text('Aaron Burr'),
                    ),
                  ),
                );
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
