import 'package:flutter/material.dart';
const _PATH = "assets/images";

class Product {
  const Product({required this.name});

  final String name;
}

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({required this.count, super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Quantità: $count',
        style: TextStyle(color: Colors.white));
  }
}

class CounterButton extends StatelessWidget {
  const CounterButton({required this.onPressed,required this.label, super.key});
  final Icon label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      // child: Text( label),
      child: label,

    );
  }
}



class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // if(_counter<quantProdotto())
      ++_counter;
    });
  }
  void _decrement() {
    setState(() {
      if(_counter>0)
        --_counter;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        height: 400.0,
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.all(10.0),
        decoration: ShapeDecoration(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(20.0))
            )
        ),
        // child:SingleChildScrollView( non so bene come funziona
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("$_PATH/mbv1.webp",
                fit: BoxFit.fill,
                //fit: BoxFit.cover,
              ),
              Container(
                padding:  const EdgeInsets.all(15.0),
                child:CounterDisplay(count: _counter),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CounterButton(onPressed: _increment,label:Icon( Icons.add, color: Colors.deepOrange, )),
                  const SizedBox(width: 5),
                  CounterButton(onPressed: _decrement,label:Icon( Icons.remove, color: Colors.deepOrange, ))
                ],
              )
            ]
        )
      //)
    );
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
              child: Text(

                'Item $index',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            );
          }),
        ),
      ),
    );
  }
}