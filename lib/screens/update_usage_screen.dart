import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:money_manager/bloc/money_updates_bloc.dart';
import 'package:my_tools_bag/my_tools_bag.dart';

import '../models/money_usage.dart';
import 'used_money_chart_screen.dart';

class UpdateUsageScreen extends StatefulWidget {
  final MoneyUsage moneyUpdates;
  const UpdateUsageScreen({super.key, required this.moneyUpdates});

  @override
  State<UpdateUsageScreen> createState() => _UpdateUsageScreenState();
}

class _UpdateUsageScreenState extends State<UpdateUsageScreen> {
  final TextEditingController _moneyUsage = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _purchase = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _updatedDate = DateTime.now();
  @override
  void initState() {
    _date.text = DateTime.now().toString().split(" ")[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 200,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BeautyTextField(
                    fieldName: 'المشترى',
                    controller: _purchase,
                  ),
                  BeautyTextField(
                    fieldName: 'المبلغ',
                    controller: _moneyUsage,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2999),
                        initialDate: DateTime.now(),
                        selectableDayPredicate: (day) {
                          return true;
                        },
                      ).then((date) {
                        if (date != null) {
                          _updatedDate = date;
                          _date.text = date.toString().split(" ")[0];
                        }
                        setState(() {});
                      });
                    },
                    child: SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _date,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        keyboardType: TextInputType.datetime,
                        enabled: false,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: _onSave,
                      child: const Text("حفظ"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String dayId =
        '${_updatedDate.year}-${_updatedDate.month}-${_updatedDate.day}';
    // int updateIndex = -1;

    Expense update = Expense(
      dayId: dayId,
      date: _updatedDate,
      usedMoney: int.parse(_moneyUsage.text),
      purchase: _purchase.text,
    );

    // updateIndex = widget.moneyUpdates.expenses
    //     .indexWhere((element) => element.dayId == dayId);
    // log('$updateIndex');
    // if (updateIndex > -1) {
    //   widget.moneyUpdates.expenses[updateIndex] = update;
    // } else {
    widget.moneyUpdates.expenses.add(update);
    // }
    BlocProvider.of<MoneyBloc>(context);
    BlocProvider.of<MoneyBloc>(context)
        .add(SaveMoneyUsage(widget.moneyUpdates));

    Get.offAll(() => const UsedMoneyChartScreen());
  }
}
