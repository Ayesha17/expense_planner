import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _usertransaction;
  final Function _deleteItem;

  TransactionList(this._usertransaction, this._deleteItem);

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final curScaleFactor =mediaQuery.textScaleFactor;
    return _usertransaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Text(
            'No transaction added yet!',
            style: Theme
                .of(context)
                .textTheme
                .bodyText2,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.2,
          ),
          SizedBox(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ))
        ],
      );
    })
        : ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
            elevation: 5,
            margin:
            const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      "\$${_usertransaction[index].amount.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: (16 * curScaleFactor)),
                    ),
                  ),
                ),
              ),
              title: Text(
                _usertransaction[index].title,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
              ),
              subtitle: Text(
                  DateFormat.yMMMMd()
                      .format(_usertransaction[index].date),
                  style:
                  const TextStyle(fontSize: 12, color: Colors.grey)),
              trailing: mediaQuery
                  .size
                  .width > 460
                  ? TextButton.icon(
                  onPressed: () {
                    _deleteItem(_usertransaction[index].id);
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Delete'))
                  : IconButton(
                icon: Icon(Icons.delete),
                color: Theme
                    .of(context)
                    .errorColor,
                onPressed: () =>
                    _deleteItem(_usertransaction[index].id),
              ),
            ));
        // Card(
        //   elevation: 4,
        //   child: Row(
        //     children: [
        //       Container(
        //         child: Text(
        //           "\$${_usertransaction[index].amount.toStringAsFixed(2)}",
        //           style:  TextStyle(
        //               color:Theme.of(context).colorScheme.primary,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 16),
        //         ),
        //         margin: const EdgeInsets.symmetric(
        //             vertical: 10, horizontal: 15),
        //         decoration: BoxDecoration(
        //             border: Border.all(color: Theme.of(context).colorScheme.primary, width: 0.5)),
        //         padding: EdgeInsets.all(10.0),
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(bottom: 4.0),
        //             child: Text(
        //               _usertransaction[index].title,
        //               textAlign: TextAlign.start,
        //               style: Theme.of(context).textTheme.bodyText2,
        //               // style: const TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //           ),
        //           Text(
        //             DateFormat.yMMMMd()
        //                 .format(_usertransaction[index].date),
        //             style:
        //                 const TextStyle(fontSize: 10, color: Colors.grey),
        //           )
        //         ],
        //       )
        //     ],
        //   ));
      },
      itemCount: _usertransaction.length,
    );
  }
}
