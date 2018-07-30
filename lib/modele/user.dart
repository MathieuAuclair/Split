import 'package:split_app/modele/spent.dart';

class User {
  String name;
  List<Spent> spending;

  User({this.name, this.spending});

  Map<String, dynamic> toJson() => {
    'name': name,
    'spending': spending,
  };

  void fromJson(json) {
    name = json['name'];
    spending = json['spending'];
  }

  double getUserPaidAmount(){
    double paidAmount = 0.0;
    for(Spent spent in spending){
      paidAmount += spent.amount;
    }

    return paidAmount;
  }
}