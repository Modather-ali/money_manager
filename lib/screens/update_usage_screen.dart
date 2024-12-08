import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:get/get.dart';
import 'package:money_manager/tools/logger_utils.dart';

import '../bloc/money_updates_bloc.dart';
import '../models/money_usage.dart';
import 'categories_screen.dart';
import 'money_usage_screen.dart';
import 'widgets/beauty_text_field.dart';

class UpdateUsageScreen extends StatefulWidget {
  final MoneyUsage moneyUsage;
  final int transactionIndex;
  const UpdateUsageScreen({
    super.key,
    required this.moneyUsage,
    this.transactionIndex = -1,
  });

  @override
  State<UpdateUsageScreen> createState() => _UpdateUsageScreenState();
}

class _UpdateUsageScreenState extends State<UpdateUsageScreen> {
  final TextEditingController _usedMoney = TextEditingController();
  final TextEditingController _purchase = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime _transactionDate = DateTime.now();
  String _transactionType = 'expense';
  String? _categoryId;
  late Transaction transaction;
  late List<Category> _categories;
  @override
  void initState() {
    _categories = widget.moneyUsage.categories;
    if (widget.transactionIndex > -1) {
      transaction = widget.moneyUsage.transactions[widget.transactionIndex];
      _usedMoney.text = transaction.usedMoney.toString();
      _purchase.text = transaction.purchase;

      _transactionDate = transaction.date;
      _transactionType = transaction.type;
      if (transaction.categoryId.isNotEmpty) {
        _categoryId = transaction.categoryId;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const CategoriesScreen(),
                    transition: Transition.upToDown);
              },
              icon: const Icon(Icons.category)),
          if (widget.transactionIndex > -1)
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('حذف؟'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (_transactionType == 'expense') {
                                widget.moneyUsage.egpBalance +=
                                    transaction.usedMoney;
                                widget.moneyUsage.budget +=
                                    transaction.usedMoney;
                              } else {
                                widget.moneyUsage.egpBalance -=
                                    transaction.usedMoney;
                              }
                              widget.moneyUsage.transactions
                                  .removeAt(widget.transactionIndex);
                              BlocProvider.of<MoneyBloc>(context)
                                  .add(SaveMoneyUsage(widget.moneyUsage));

                              Get.offAll(() => const MoneyUsageScreen());
                            },
                            child: const Text('نعم'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
        ],
      ),
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
                    height: 100,
                    width: double.infinity,
                  ),
                  BeautyTextField(
                    fieldName: 'المشترى',
                    controller: _purchase,
                  ),
                  BeautyTextField(
                    fieldName: 'المبلغ',
                    controller: _usedMoney,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: _onPickDate,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            '${_transactionDate.toString().split(" ")[1].split('.')[0]} ${_transactionDate.toString().split(" ")[0]}',
                        hintStyle: const TextStyle(fontSize: 12),
                        focusedBorder: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.date_range),
                      ),
                      keyboardType: TextInputType.datetime,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('نوع المعاملة:'),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: DropdownButton(
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                            value: 'expense', child: Text('نفقات')),
                        DropdownMenuItem(
                            value: 'deposit', child: Text('ايداع')),
                        DropdownMenuItem(
                            value: 'transfer', child: Text('تحويل')),
                      ],
                      value: _transactionType,
                      onChanged: (value) {
                        _transactionType = value!;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('الفئة:'),
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: DropdownButton(
                      isExpanded: true,
                      items: [
                        for (var category in _categories)
                          DropdownMenuItem(
                              value: category.id, child: Text(category.name)),
                      ],
                      value: _categoryId,
                      onChanged: (value) {
                        _categoryId = value!;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
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

    if (widget.transactionIndex > -1) {
      transaction = transaction.copyWith(
        date: _transactionDate,
        usedMoney: double.parse(_usedMoney.text),
        purchase: _purchase.text,
        type: _transactionType,
        categoryId: _categoryId,
      );

      widget.moneyUsage.transactions[widget.transactionIndex] = transaction;
    } else {
      String dayId =
          '${_transactionDate.year}-${_transactionDate.month}-${_transactionDate.day}';

      transaction = Transaction(
        dayId: dayId,
        date: _transactionDate,
        usedMoney: double.parse(_usedMoney.text),
        purchase: _purchase.text,
        type: _transactionType,
        categoryId: _categoryId ?? '',
      );

      widget.moneyUsage.transactions.add(transaction);
      if (_transactionType == 'expense') {
        widget.moneyUsage.egpBalance -= transaction.usedMoney;
        widget.moneyUsage.budget -= transaction.usedMoney;
      } else {
        widget.moneyUsage.egpBalance += transaction.usedMoney;
      }
    }

    BlocProvider.of<MoneyBloc>(context).add(SaveMoneyUsage(widget.moneyUsage));

    Get.offAll(() => const MoneyUsageScreen());
  }

  void _onPickDate() async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2999),
      initialDate: DateTime.now(),
      selectableDayPredicate: (day) {
        return true;
      },
    ).then((date) async {
      if (date != null) {
        _transactionDate = date;
        Logger.print(date.toString());
        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((TimeOfDay? timeOfDay) {
          if (timeOfDay != null) {
            _transactionDate = date.copyWith(
              hour: timeOfDay.hour,
              minute: timeOfDay.minute,
            );
            Logger.print(timeOfDay);
          }
        });
      }
      setState(() {});
    });
  }
}
