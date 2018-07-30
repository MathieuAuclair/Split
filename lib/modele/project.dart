import 'package:split_app/modele/user.dart';

class Project {
  String name;
  List<User> users;

  Project({this.name, this.users});

  Map<String, dynamic> toJson() => {
    'name': name,
    'users': users,
  };

  void fromJson(json) {
    name = json['name'];
    users = json['users'];
  }

  double getProjectAmountTotal(){
    double amount = 0.0;
    for(User user in users){
      amount += user.getUserPaidAmount();
    }

    return amount;
  }
}