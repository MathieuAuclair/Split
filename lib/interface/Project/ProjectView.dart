import 'package:flutter/material.dart';
import 'package:split_app/modele/project.dart';
import 'package:split_app/modele/user.dart';

class ProjectView extends StatefulWidget {
  final Project project;

  ProjectView(this.project);

  @override
  State<StatefulWidget> createState() => ProjectViewState(project);
}

class ProjectViewState extends State<ProjectView> {
  final Project project;

  List<Widget> users;

  ProjectViewState(this.project);

  @override
  void initState() {
    for (User user in project.users) {
      users.add(new Text(
          user.name + " paid for " + user.getUserPaidAmount().toString()));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(children: users);
  }
}
