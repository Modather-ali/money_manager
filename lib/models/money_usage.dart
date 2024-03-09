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
  int egpBalance;
  int usdBalance;
  int usdToEgp;
  List<Transaction> transactions;

  MoneyUsage({
    this.id = '',
    required this.lastUpdate,
    this.egpBalance = 0,
    this.usdBalance = 0,
    this.usdToEgp = 0,
    required this.transactions,
  });

  MoneyUsage copyWith({
    String? id,
    DateTime? lastUpdate,
    int? egpBalance,
    int? usdBalance,
    int? usdToEgp,
    List<Transaction>? transactions,
  }) =>
      MoneyUsage(
        id: id ?? this.id,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        egpBalance: egpBalance ?? this.egpBalance,
        usdBalance: usdBalance ?? this.usdBalance,
        usdToEgp: usdToEgp ?? this.usdToEgp,
        transactions: transactions ?? this.transactions,
      );

  factory MoneyUsage.fromJson(Map<String, dynamic> json) => MoneyUsage(
        id: json["id"],
        lastUpdate: DateTime.parse(json["last_update"]),
        egpBalance: json["egp_balance"] ?? 0,
        usdBalance: json["usd_balance"] ?? 0,
        usdToEgp: json["usd_to_egp"] ?? 0,
        transactions: json["transactions"] == null
            ? List<Transaction>.from(
                json["expenses"].map((x) => Transaction.fromJson(x)))
            : List<Transaction>.from(
                json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_update": lastUpdate.toIso8601String(),
        "egp_balance": egpBalance,
        "usd_balance": usdBalance,
        "usd_to_egp": usdToEgp,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  String dayId;
  String purchase;
  int usedMoney;
  String type;
  DateTime date;

  Transaction({
    required this.dayId,
    required this.purchase,
    required this.usedMoney,
    required this.type,
    required this.date,
  });

  Transaction copyWith({
    String? dayId,
    String? purchase,
    int? usedMoney,
    String? type,
    DateTime? date,
  }) =>
      Transaction(
        dayId: dayId ?? this.dayId,
        purchase: purchase ?? this.purchase,
        usedMoney: usedMoney ?? this.usedMoney,
        type: type ?? this.type,
        date: date ?? this.date,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        dayId: json["day_id"],
        purchase: json["purchase"],
        usedMoney: json["used_money"],
        type: json["type"] ?? "expense",
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "purchase": purchase,
        "used_money": usedMoney,
        "type": type,
        "date": date.toIso8601String(),
      };
}
