import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_manager/models/money_updates.dart';

import '/screens/chart_screen.dart';
import '../service/cloud_firestore.dart';

class UpdateUsageScreen extends StatefulWidget {
  final MoneyUpdates moneyUpdates;
  const UpdateUsageScreen({super.key, required this.moneyUpdates});

  @override
  State<UpdateUsageScreen> createState() => _UpdateUsageScreenState();
}

class _UpdateUsageScreenState extends State<UpdateUsageScreen> {
  final TextEditingController _income = TextEditingController();
  final TextEditingController _outcome = TextEditingController();
  final TextEditingController _date = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
                width: double.infinity,
              ),
              // _moneyTextFormField(
              //   color: Colors.green,
              //   controller: _income,
              // ),
              const SizedBox(
                height: 20,
              ),
              _moneyTextFormField(
                controller: _outcome,
                color: Colors.red,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2999),
                    initialDate: DateTime.now(),
                    selectableDayPredicate: (day) {
                      print(day);
                      return true;
                    },
                  ).then((date) {
                    if (date != null) {
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
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() async {
    bool result;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    result = await CloudFirestore().addStatisticsData(
      date: _date.text,
      income: num.parse(_income.text),
      outcome: num.parse(_outcome.text),
    );
    if (result) {
      Get.offAll(() => const ChartScreen());
    } else {
      // Get.showSnackbar(
      //   const GetSnackBar(
      //     title: "Error",
      //     message: "",
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  Widget _moneyTextFormField({
    TextEditingController? controller,
    Color? color,
  }) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(),
          // prefixIcon: Icon(
          //   Icons.attach_money,
          //   color: color,
          // ),
        ),
        // inputFormatters: const <TextInputFormatter>[
        // FilteringTextInputFormatter.digitsOnly
        // ],
        validator: (text) {
          final isNumber = num.tryParse(text!);
          if (text.isEmpty) {
            return "This value is empty";
          } else if (isNumber == null) {
            return '"$text" is not a valid number';
          }
          return null;
        },
        keyboardType: TextInputType.number,
      ),
    );
  }
}
