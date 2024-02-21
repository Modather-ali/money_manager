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
      : super(GetMoneyUpdates(MoneyUsage(
            lastUpdate: DateTime.now(),
            expenses: [],
            id: FirebaseAuth.instance.currentUser!.uid))) {
    on<SaveMoneyUpdates>((event, emit) {
      event.moneyUsage.id = FirebaseAuth.instance.currentUser!.uid;
      FireDatabase.saveItemData(event.moneyUsage,
          collectionPath: 'money_usage');
      emit(GetMoneyUpdates(event.moneyUsage));
    });

    on<GetMoneyUpdates>((event, emit) async {
      MoneyUsage moneyUsage =
          MoneyUsage(lastUpdate: DateTime.now(), expenses: [], id: '');

      Map<String, dynamic>? item = await FireDatabase.getItemData(
        collectionPath: 'money_usage',
        id: FirebaseAuth.instance.currentUser!.uid,
      );
      if (item != null) {
        moneyUsage = MoneyUsage.fromJson(item);
      }
      moneyUsage = MoneyUsage.fromJson(item!);
      emit(GetMoneyUpdates(moneyUsage));
    });
  }
}
