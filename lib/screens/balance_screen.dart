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
  final TextEditingController _egp = TextEditingController();
  final TextEditingController _usd = TextEditingController();
  bool _isEditEGP = false;
  bool _isEditUSD = false;
  @override
  void initState() {
    _egp.text = widget.moneyUsage.egpBalance.toString();
    _usd.text = widget.moneyUsage.usdBalance.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرصيد')),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          BalanceTextField(
            fieldName: 'الجنيه',
            controller: _egp,
            isEditMode: _isEditEGP,
            onEdit: () {
              if (_isEditEGP) {
                widget.moneyUsage.egpBalance = int.parse(_egp.text);

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
            fieldName: 'الدولار',
            controller: _usd,
            isEditMode: _isEditUSD,
            onEdit: () {
              if (_isEditUSD) {
                widget.moneyUsage.usdBalance = int.parse(_usd.text);

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
        ],
      ),
    );
  }
}
