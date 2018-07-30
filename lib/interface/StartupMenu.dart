import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:split_app/Handler/ProjectHandler.dart';

import 'package:split_app/modele/project.dart';
import 'package:split_app/modele/user.dart';

class StartupMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new StartupMenuPage();
}

class StartupMenuPage extends State<StartupMenu> {
  final userTextController = TextEditingController();
  final projectTextController = TextEditingController();

  List<Widget> usersChips = [];

  List<User> users = new List<User>();

  @override
  void dispose() {
    userTextController.dispose();
    projectTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
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
              padding:
                  new EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                children: usersChips,
              ),
            ),
            new Container(
              margin: new EdgeInsets.only(bottom: 20.0),
              child: new RaisedButton(
                onPressed: _addNewUserPrompt,
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
                onPressed: () {
                  users = [];
                  usersChips = [];
                  setState(() {});
                },
                child: new Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: new EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025,
                  ),
                  child: new Text(
                    "Clear current users",
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
                onPressed: _createProject,
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
    );
  }

  Future<Null> _addNewUserPrompt() async {
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
                      labelText: 'user\'s name',
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
                users.add(
                  new User(
                    name: userTextController.text,
                    spending: [],
                  ),
                );
                usersChips.add(
                  new Container(
                    margin: new EdgeInsets.all(5.0),
                    child: new Chip(
                      avatar: new CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: new Icon(Icons.account_circle),
                      ),
                      label: new Text(userTextController.text),
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

  Future _createProject() async {
    Project project = new Project(
      name: projectTextController.text,
      users: users,
    );

    ProjectHandler.addNewProjectToSharedPreferences(project);

    projectTextController.clear();
    usersChips = [];
    users = [];

    Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(
              "Project succesfully created!",
              textAlign: TextAlign.center,
            ),
          ),
        );

    setState(() {});
  }
}
