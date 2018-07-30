class Spent {
  String name;
  double amount;

  Spent({this.name, this.amount});

  Map<String, dynamic> toJson() => {
    'name': name,
    'amount': amount,
  };

  void fromJson(json) {
    name = json['name'];
    amount = json['amount'];
  }
}
