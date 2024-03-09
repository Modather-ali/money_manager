import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_tools_bag/firebase/firebase.dart';

import '../models/money_usage.dart';

sealed class MoneyEvent {}

final class SaveMoneyUsage extends MoneyEvent {
  final MoneyUsage moneyUsage;

  SaveMoneyUsage(this.moneyUsage);
}

class GetMoneyUsage extends MoneyEvent {
  final MoneyUsage? moneyUsage;
  GetMoneyUsage(this.moneyUsage);
}

class MoneyBloc extends Bloc<MoneyEvent, GetMoneyUsage> {
  MoneyBloc() : super(GetMoneyUsage(null)) {
    on<SaveMoneyUsage>((event, emit) {
      event.moneyUsage.id = FirebaseAuth.instance.currentUser!.uid;
      FireDatabase.saveItemData(event.moneyUsage,
          collectionPath: 'money_usage');
      emit(GetMoneyUsage(event.moneyUsage));
    });

    on<GetMoneyUsage>((event, emit) async {
      MoneyUsage moneyUsage =
          MoneyUsage(lastUpdate: DateTime.now(), transactions: [], id: '');

      Map<String, dynamic>? item = await FireDatabase.getItemData(
        collectionPath: 'money_usage',
        id: FirebaseAuth.instance.currentUser!.uid,
      );
      if (item != null) {
        moneyUsage = MoneyUsage.fromJson(item);
      }
      moneyUsage = MoneyUsage.fromJson(item!);
      emit(GetMoneyUsage(moneyUsage));
    });
  }
}
