import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/widgets/new_transaction.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // ThemeData themeData = ThemeData();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: themeData.copyWith(
      //   colorScheme: themeData.colorScheme.copyWith(
      //     primary: Colors.green,
      //     secondary: Colors.purple
      //   )
      // ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.green,
        ),
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          titleTextStyle:  TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.brown,fontFamily: 'OpenSans',fontWeight: FontWeight.bold)),
      ),
      home: const MyHomePage(title: 'Expense Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.98, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'New Shoes 1', amount: 65.98, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'New Shoes 2', amount: 62.98, date: DateTime.now()),
  ];

  List<Transaction>? get recentTransaction{
    return _usertransaction.where((element) {
       return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _usertransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //new line
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add))
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Chart(_usertransaction)
          ),
          TransactionList(_usertransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
