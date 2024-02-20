// To parse this JSON data, do
//
//     final moneyUsage = moneyUsageFromJson(jsonString);

import 'dart:convert';

MoneyUsage moneyUsageFromJson(String str) =>
    MoneyUsage.fromJson(json.decode(str));

String moneyUsageToJson(MoneyUsage data) => json.encode(data.toJson());

class MoneyUsage {
  String id;
  DateTime lastUpdate;
  List<Expense> expenses;

  MoneyUsage({
    this.id = '',
    required this.lastUpdate,
    required this.expenses,
  });

  MoneyUsage copyWith({
    String? id,
    DateTime? lastUpdate,
    List<Expense>? expenses,
  }) =>
      MoneyUsage(
        id: id ?? this.id,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        expenses: expenses ?? this.expenses,
      );

  factory MoneyUsage.fromJson(Map<String, dynamic> json) => MoneyUsage(
        id: json["id"],
        lastUpdate: DateTime.parse(json["last_update"]),
        expenses: List<Expense>.from(
            json["expenses"].map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_update": lastUpdate.toIso8601String(),
        "expenses": List<dynamic>.from(expenses.map((x) => x.toJson())),
      };
}

class Expense {
  String dayId;
  String purchase;
  int usedMoney;
  DateTime date;

  Expense({
    required this.dayId,
    required this.purchase,
    required this.usedMoney,
    required this.date,
  });

  Expense copyWith({
    String? dayId,
    String? purchase,
    int? usedMoney,
    DateTime? date,
  }) =>
      Expense(
        dayId: dayId ?? this.dayId,
        purchase: purchase ?? this.purchase,
        usedMoney: usedMoney ?? this.usedMoney,
        date: date ?? this.date,
      );

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        dayId: json["day_id"],
        purchase: json["purchase"],
        usedMoney: json["used_money"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "purchase": purchase,
        "used_money": usedMoney,
        "date": date.toIso8601String(),
      };
}
