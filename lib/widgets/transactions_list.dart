import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                      elevation: 5,
                      child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: FittedBox(
                                      child: Text(
                                          'Rs.${transactions[index].amount}')))),
                          title: Text(transactions[index].title,
                              style: Theme.of(context).textTheme.titleMedium),
                          subtitle: Text(DateFormat.yMMMd()
                              .format(transactions[index].date)),
                          trailing: IconButton(
                              onPressed: () => deletetx(transactions[index].id),
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor)));
                },
                itemCount: transactions.length,
              ));
  }
}
