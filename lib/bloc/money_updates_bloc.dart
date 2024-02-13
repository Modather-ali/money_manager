import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/models/money_updates.dart';
import 'package:my_tools_bag/firebase/firebase.dart';

sealed class MoneyEvent {}

final class SaveMoneyUpdates extends MoneyEvent {
  final MoneyUpdates moneyUpdates;

  SaveMoneyUpdates(this.moneyUpdates);
}

class GetMoneyUpdates extends MoneyEvent {
  final MoneyUpdates moneyUpdates;
  GetMoneyUpdates(this.moneyUpdates);
}

class MoneyBloc extends Bloc<MoneyEvent, GetMoneyUpdates> {
  MoneyBloc()
      : super(GetMoneyUpdates(
            MoneyUpdates(lastUpdate: DateTime.now(), updates: []))) {
    on<SaveMoneyUpdates>((event, emit) {
      // event.moneyUpdates.id = FirebaseAuth.instance.currentUser!.uid;
      FireDatabase.saveItemData(event.moneyUpdates,
          collectionPath: 'money_updates');
      emit(GetMoneyUpdates(event.moneyUpdates));
    });

    on<GetMoneyUpdates>((event, emit) async {
      MoneyUpdates moneyUpdates =
          MoneyUpdates(lastUpdate: DateTime.now(), updates: []);

      List<Map<String, dynamic>> items =
          await FireDatabase.getListOfItems(collectionPath: 'money_updates');

      List<MoneyUpdates> updates =
          List<MoneyUpdates>.from(items.map((e) => MoneyUpdates.fromJson(e)));
      if (updates.isNotEmpty) {
        moneyUpdates = updates.first;
      }
      emit(GetMoneyUpdates(moneyUpdates));
    });
  }
}
