import 'package:flutter/material.dart';
import 'package:my_tools_bag/tools/date_formatter.dart';

import '../../models/money_usage.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(transaction.purchase),
        subtitle: Row(
          children: [
            Text(
              '${transaction.usedMoney} جنيه',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: _transactionColor()),
            ),
            const SizedBox(width: 10),
            Text(DateFormatter.formatDateAR(
              transaction.date,
              isFull: false,
            )),
          ],
        ),
      ),
    );
  }

  Color _transactionColor() {
    switch (transaction.type) {
      case 'expense':
        return Colors.deepOrange;
      case 'deposit':
        return Colors.green;
      case 'transfer':
        return Colors.blueGrey;
      default:
        return Colors.orange;
    }
  }
}
