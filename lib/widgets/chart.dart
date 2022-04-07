import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        // print('recent day ${recentTransactions[i].date.day} ${weekDay.day}');
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': double.parse(totalSum.toStringAsFixed(2))
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('test $groupedTransactionValues $maxSpending');
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(10),
        child: Padding(
        padding: EdgeInsets.all(6.0),
        child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Expanded(
               flex: 1,
                    child: ChartBar(
                        data['day'].toString(),
                        data['amount'] as double,
                        maxSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / maxSpending));
              }).toList()),
        ));
  }
}
