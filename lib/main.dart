import 'package:flutter/material.dart';
import 'package:personal_transactions/widgets/transactions_list.dart';
import 'package:personal_transactions/widgets/new_transaction.dart';
import '../models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput = "";

  final List<Transaction> _transactions = [
    // Transaction(id: 't1', title: 'New Shoes', amount: 50, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Groceries', amount: 25, date: DateTime.now()),
  ];
  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String txtitle, double amt, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: amt,
        date: chosenDate);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _removeTransaction(String ID) {
    setState(() {
      _transactions.removeWhere((element) {
        return element.id == ID;
      });
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: Text(
                'PERSONAL TRANSACTIONS',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () => _startAddNewTransaction(context),
                    icon: Icon(Icons.add)),
              ]),
          body: SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                Chart(_recentTransactions),
                TransactionList(_transactions, _removeTransaction),
              ])),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ));
  }
}
