import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_app/Constant.dart';
import 'package:split_app/modele/project.dart';

class ProjectHandler {
  static Future<String> getJsonSaveContentFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String json = preferences.getString(Constant.SP_KEY_SAVES);

    return json;
  }

  static List<Project> getSavedProject(String jsonContent) {
    if(jsonContent == null){
      return [];
    }

    List<Project> projects = new List<Project>();
    List<dynamic> jsonProjects = json.decode(jsonContent);

    for (dynamic key in jsonProjects) {

      Project project = new Project();
      project.fromJson(key);
      projects.add(project);
    }

    return projects;
  }

  static Future addNewProjectToSharedPreferences(Project project) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonProjects = preferences.getString(Constant.SP_KEY_SAVES);

    if(jsonProjects == null){
      jsonProjects = "[]";
    }

    var projects = json.decode(jsonProjects);

    projects.add(project.toJson());
    preferences.setString(Constant.SP_KEY_SAVES, json.encode(projects));
  }
}
