import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewTransactionState();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    var title = titleController.text;
    var amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0) {
      return;
    }
    widget.addNewTransaction(title, amount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (value)=>titleText=value,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                onSubmitted: (_) => submitData(),
                // onChanged: (value) => amount=value,
                decoration: InputDecoration(label: Text('Amount')),
              ),
              TextButton(onPressed: submitData, child: Text('Add Transaction'))
            ],
          ),
        ));
  }
}
