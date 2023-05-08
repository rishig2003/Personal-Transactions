import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amtController = TextEditingController();

  DateTime _pickedDate = DateTime.now();

  void _submitData() {
    if (_amtController.text.isEmpty) {
      return;
    }
    final titleentered = _titleController.text;
    final amtentered = _amtController.text;

    if (titleentered.isEmpty || amtentered == 0 || _pickedDate == null) {
      return;
    }
    widget.addTx(
        _titleController.text, double.parse(_amtController.text), _pickedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((picked) {
      if (picked == null) {
        return;
      } else {
        setState(() {
          _pickedDate = picked;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData,
                    // onChanged: (value) {
                    //   titleInput = value;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    controller: _amtController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData,
                    // onChanged: (value) {
                    //   amountInput = value;
                    // },
                  ),
                  Container(
                    height: 70,
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text(
                        _pickedDate == DateTime.now()
                            ? "No date picked"
                            : 'Picked date ${DateFormat.yMd().format(_pickedDate)}',
                      )),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: Text("Choose date",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold))),
                    ]),
                  ),
                  ElevatedButton(
                    child: Text("Add transaction",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: _submitData,
                  )
                ])));
  }
}
