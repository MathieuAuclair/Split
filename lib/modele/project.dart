import 'dart:convert';

import 'package:split_app/modele/user.dart';

class Project {
  String name;
  List<User> users;

  Project({this.name, this.users});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'users': _getJsonStringForListUser(),
      };

  void fromJson(jsonContent) {
    name = jsonContent['name'];
    users = _getUsersFromJson(json.decode(jsonContent['users']));
  }

  double getProjectAmountTotal() {
    double amount = 0.0;
    for (User user in users) {
      amount += user.getUserPaidAmount();
    }

    return amount;
  }

  String _getJsonStringForListUser() {
    var jsonContent = [];
    for (User user in users) {
      jsonContent.add(json.encode(user.toJson()));
    }

    print(json.encode(jsonContent));

    return json.encode(jsonContent);
  }

  List<User> _getUsersFromJson(jsonContent) {
    List<User> users = new List<User>();
    for(var jsonUser in jsonContent){
      User user = new User();
      user.fromJson(jsonUser);
      users.add(user);
    }
    return users;
  }
}