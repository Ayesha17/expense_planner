import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'adaptive_button.dart';

class NewTransaction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewTransactionState();
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  DateTime? _pickedDate = null;
  final _amountController = TextEditingController();

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    var title = _titleController.text;
    var amount = double.parse(_amountController.text);
    if (title.isEmpty || amount <= 0 || _pickedDate == null) {
      return;
    }
    widget.addNewTransaction(title, amount, _pickedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 30)),
            lastDate: DateTime.now().add(const Duration(days: 90)))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Card(
            elevation: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (value)=>titleText=value,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        onSubmitted: (_) => _submitData(),
                        // onChanged: (value) => amount=value,
                      )),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(_pickedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date : ${DateFormat.yMd().format(_pickedDate)}')),
                      AdaptiveButton('Choose Date', _presentDatePicker)
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                          onPressed: _submitData,
                          style: ButtonStyle(
                              backgroundColor: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.backgroundColor),
                          child: const Text('Add Transaction',
                              style: TextStyle(fontWeight: FontWeight.bold))))
                ],
              ),
            )));
  }
}
