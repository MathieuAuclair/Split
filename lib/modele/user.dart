import 'dart:convert';

import 'package:split_app/modele/spent.dart';

class User {
  String name;
  List<Spent> spending;

  User({this.name, this.spending});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'spending': _getJsonStringForSpent(),
      };

  void fromJson(jsonContent) {
    name = json.decode(jsonContent)['name'];
    spending = _getSpentFromJson(json.decode(jsonContent)['spending']);
  }

  double getUserPaidAmount() {
    double paidAmount = 0.0;
    for (Spent spent in spending) {
      paidAmount += spent.amount;
    }

    return paidAmount;
  }

  String _getJsonStringForSpent() {
    var jsonContent = [];
    for (Spent spent in spending) {
      jsonContent.add(json.encode(spent.toJson()));
    }

    return json.encode(jsonContent);
  }

  List<Spent> _getSpentFromJson(jsonContent) {
    List<Spent> spending = new List<Spent>();
    for(var jsonSpent in json.decode(jsonContent)){
      Spent spent = new Spent();
      spent.fromJson(jsonSpent);
      spending.add(spent);
    }

    return spending;
  }
}