import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_app/Constant.dart';
import 'package:split_app/modele/project.dart';

class ProjectHandler {
  static Future<String> getJsonSaveContentFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = preferences.getString(Constant.SP_KEY_SAVES);

    if(json == null) {
      return "[]";
    }

    return json;
  }

  static Future<List<Project>> getSavedProject(
      Future<String> jsonContent) async {
    List<Project> projects = new List<Project>();
    var jsonProjects = json.decode(await jsonContent);

    for (String json in jsonProjects) {
      Project project = new Project();
      project.fromJson(json);
      projects.add(project);
    }

    return projects;
  }
}
