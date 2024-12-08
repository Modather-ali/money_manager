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
  double egpBalance;
  double usdBalance;
  double usdSavings;
  double usdToEgp;
  double budget;
  List<Category> categories;
  List<Transaction> transactions;

  MoneyUsage({
    this.id = '',
    required this.lastUpdate,
    this.egpBalance = 0,
    this.usdBalance = 0,
    this.usdSavings = 0,
    this.usdToEgp = 0,
    this.budget = 0,
    this.categories = const [],
    this.transactions = const [],
  });

  MoneyUsage copyWith({
    String? id,
    DateTime? lastUpdate,
    double? egpBalance,
    double? usdBalance,
    double? usdSavings,
    double? usdToEgp,
    double? budget,
    List<Category>? categories,
    List<Transaction>? transactions,
  }) =>
      MoneyUsage(
        id: id ?? this.id,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        egpBalance: egpBalance ?? this.egpBalance,
        usdBalance: usdBalance ?? this.usdBalance,
        usdSavings: usdSavings ?? this.usdSavings,
        usdToEgp: usdToEgp ?? this.usdToEgp,
        budget: budget ?? this.budget,
        categories: categories ?? this.categories,
        transactions: transactions ?? this.transactions,
      );

  factory MoneyUsage.fromJson(Map<String, dynamic> json) => MoneyUsage(
        id: json["id"],
        lastUpdate: DateTime.parse(json["last_update"]),
        egpBalance: json["egp_balance"]?.toDouble(),
        usdBalance: json["usd_balance"]?.toDouble(),
        usdSavings: json["usd_savings"]?.toDouble(),
        usdToEgp: json["usd_to_egp"]?.toDouble(),
        budget: json["budget"] ?? 0,
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_update": lastUpdate.toIso8601String(),
        "egp_balance": egpBalance,
        "usd_balance": usdBalance,
        "usd_savings": usdSavings,
        "usd_to_egp": usdToEgp,
        "budget": budget,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  Category copyWith({
    String? id,
    String? name,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Transaction {
  String dayId;
  String categoryId;
  String purchase;
  double usedMoney;
  String type;
  DateTime date;

  Transaction({
    required this.dayId,
    required this.categoryId,
    required this.purchase,
    required this.usedMoney,
    required this.type,
    required this.date,
  });

  Transaction copyWith({
    String? dayId,
    String? categoryId,
    String? purchase,
    double? usedMoney,
    String? type,
    DateTime? date,
  }) =>
      Transaction(
        dayId: dayId ?? this.dayId,
        categoryId: categoryId ?? this.categoryId,
        purchase: purchase ?? this.purchase,
        usedMoney: usedMoney ?? this.usedMoney,
        type: type ?? this.type,
        date: date ?? this.date,
      );

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        dayId: json["day_id"],
        categoryId: json["category_id"],
        purchase: json["purchase"],
        usedMoney: json["used_money"]?.toDouble(),
        type: json["type"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "category_id": categoryId,
        "purchase": purchase,
        "used_money": usedMoney,
        "type": type,
        "date": date.toIso8601String(),
      };
}
