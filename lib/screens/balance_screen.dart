import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/money_updates_bloc.dart';
import '../models/money_usage.dart';
import 'widgets/balance_text_field.dart';

class BalanceScreen extends StatefulWidget {
  final MoneyUsage moneyUsage;
  const BalanceScreen({super.key, required this.moneyUsage});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  final _budget = TextEditingController();
  final _egp = TextEditingController();
  final _usd = TextEditingController();
  final _usdSavings = TextEditingController();

  bool _isEditBudget = false;
  bool _isEditEGP = false;
  bool _isEditUSD = false;
  bool _isEditUSDSavings = false;
  @override
  void initState() {
    _budget.text = widget.moneyUsage.budget.toString();
    _egp.text = widget.moneyUsage.egpBalance.toString();
    _usd.text = widget.moneyUsage.usdBalance.toString();
    _usdSavings.text = widget.moneyUsage.usdSavings.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرصيد')),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          BalanceTextField(
            currency: 'ميزانية الاسبوع',
            controller: _budget,
            isEditMode: _isEditBudget,
            onEdit: () {
              if (_isEditBudget) {
                widget.moneyUsage.budget = double.parse(_budget.text);

                BlocProvider.of<MoneyBloc>(context);
                BlocProvider.of<MoneyBloc>(context)
                    .add(SaveMoneyUsage(widget.moneyUsage));
                _isEditBudget = false;
              } else {
                _isEditBudget = true;
              }

              setState(() {});
            },
          ),
          const SizedBox(height: 15),

          BalanceTextField(
            currency: 'EGP',
            controller: _egp,
            isEditMode: _isEditEGP,
            onEdit: () {
              if (_isEditEGP) {
                widget.moneyUsage.egpBalance = double.parse(_egp.text);

                BlocProvider.of<MoneyBloc>(context);
                BlocProvider.of<MoneyBloc>(context)
                    .add(SaveMoneyUsage(widget.moneyUsage));
                _isEditEGP = false;
              } else {
                _isEditEGP = true;
              }

              setState(() {});
            },
          ),
          const SizedBox(height: 15),

          BalanceTextField(
            currency: 'USD',
            controller: _usd,
            isEditMode: _isEditUSD,
            onEdit: () {
              if (_isEditUSD) {
                widget.moneyUsage.usdBalance = double.parse(_usd.text);

                BlocProvider.of<MoneyBloc>(context);
                BlocProvider.of<MoneyBloc>(context)
                    .add(SaveMoneyUsage(widget.moneyUsage));
                _isEditUSD = false;
              } else {
                _isEditUSD = true;
              }

              setState(() {});
            },
          ),
          //------------------------------
          const SizedBox(height: 15),
          BalanceTextField(
            currency: 'المدخرات usd',
            controller: _usdSavings,
            isEditMode: _isEditUSDSavings,
            onEdit: () {
              if (_isEditUSDSavings) {
                widget.moneyUsage.usdSavings = double.parse(_usdSavings.text);

                BlocProvider.of<MoneyBloc>(context);
                BlocProvider.of<MoneyBloc>(context)
                    .add(SaveMoneyUsage(widget.moneyUsage));
                _isEditUSDSavings = false;
              } else {
                _isEditUSDSavings = true;
              }

              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
