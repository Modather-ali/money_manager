import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/chart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const ChartScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _addMoneyValue = TextEditingController();
  final TextEditingController _usedMoneyValue = TextEditingController();
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
              _moneyTextFormField(
                color: Colors.green,
                controller: _addMoneyValue,
              ),
              const SizedBox(
                height: 20,
              ),
              _moneyTextFormField(
                controller: _usedMoneyValue,
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
// _formKey.currentState.save()
                    }
                  },
                  child: const Text("Add"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _moneyTextFormField({
    TextEditingController? controller,
    Color? color,
  }) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.attach_money,
            color: color,
          ),
        ),
        inputFormatters: const <TextInputFormatter>[
          // FilteringTextInputFormatter.digitsOnly
        ],
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
