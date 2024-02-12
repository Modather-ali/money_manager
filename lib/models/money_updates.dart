// To parse this JSON data, do
//
//     final moneyUpdates = moneyUpdatesFromJson(jsonString);

import 'dart:convert';

MoneyUpdates moneyUpdatesFromJson(String str) =>
    MoneyUpdates.fromJson(json.decode(str));

String moneyUpdatesToJson(MoneyUpdates data) => json.encode(data.toJson());

class MoneyUpdates {
  String id;
  DateTime lastUpdate;
  List<Update> updates;

  MoneyUpdates({
    this.id = 'money_updates',
    required this.lastUpdate,
    required this.updates,
  });

  MoneyUpdates copyWith({
    String? id,
    DateTime? lastUpdate,
    List<Update>? updates,
  }) =>
      MoneyUpdates(
        id: id ?? this.id,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        updates: updates ?? this.updates,
      );

  factory MoneyUpdates.fromJson(Map<String, dynamic> json) => MoneyUpdates(
        id: json["id"],
        lastUpdate: DateTime.parse(json["last_update"]),
        updates:
            List<Update>.from(json["updates"].map((x) => Update.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_update": lastUpdate.toIso8601String(),
        "updates": List<dynamic>.from(updates.map((x) => x.toJson())),
      };
}

class Update {
  String dayId;
  DateTime date;
  int usedMoney;

  Update({
    required this.dayId,
    required this.date,
    required this.usedMoney,
  });

  Update copyWith({
    String? dayId,
    DateTime? date,
    int? usedMoney,
  }) =>
      Update(
        dayId: dayId ?? this.dayId,
        date: date ?? this.date,
        usedMoney: usedMoney ?? this.usedMoney,
      );

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        dayId: json["day_id"],
        date: DateTime.parse(json["date"]),
        usedMoney: json["used_money"],
      );

  Map<String, dynamic> toJson() => {
        "day_id": dayId,
        "date": date.toIso8601String(),
        "used_money": usedMoney,
      };
}
