import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tools_bag/firebase/firebase.dart';

import '../models/money_usage.dart';

sealed class MoneyEvent {}

final class SaveMoneyUpdates extends MoneyEvent {
  final MoneyUsage moneyUsage;

  SaveMoneyUpdates(this.moneyUsage);
}

class GetMoneyUpdates extends MoneyEvent {
  final MoneyUsage moneyUsage;
  GetMoneyUpdates(this.moneyUsage);
}

class MoneyBloc extends Bloc<MoneyEvent, GetMoneyUpdates> {
  MoneyBloc()
      : super(GetMoneyUpdates(
            MoneyUsage(lastUpdate: DateTime.now(), expenses: [], id: ''))) {
    on<SaveMoneyUpdates>((event, emit) {
      event.moneyUsage.id = FirebaseAuth.instance.currentUser!.uid;
      FireDatabase.saveItemData(event.moneyUsage,
          collectionPath: 'money_updates');
      emit(GetMoneyUpdates(event.moneyUsage));
    });

    on<GetMoneyUpdates>((event, emit) async {
      MoneyUsage moneyUpdates =
          MoneyUsage(lastUpdate: DateTime.now(), expenses: [], id: '');

      List<Map<String, dynamic>> items =
          await FireDatabase.getListOfItems(collectionPath: 'money_updates');

      List<MoneyUsage> updates =
          List<MoneyUsage>.from(items.map((e) => MoneyUsage.fromJson(e)));
      if (updates.isNotEmpty) {
        moneyUpdates = updates.first;
      }
      emit(GetMoneyUpdates(moneyUpdates));
    });
  }
}
