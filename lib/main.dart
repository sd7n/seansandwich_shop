import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp());
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title:'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 10});

  @override
  State<OrderScreen> createState() {
    return _OrderScreenState();
  }
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _increaseQuantity() {
  if (_quantity < widget.maxQuantity) {
    setState(() => _quantity++);
  }
}

void _decreaseQuantity() {
  if (_quantity > 0) {
    setState(() => _quantity--);
  }
}

  @override
  Widget build(BuildContext context) {
    final bool canIncrease = _quantity < widget.maxQuantity;
    final bool canDecrease = _quantity > 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandwich Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OrderItemDisplay(
              _quantity,
              'Footlong',
              note: _noteController.text.trim(),
            ),

            //Inserted TextField for notes
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Notes (e.g. "no onions")',
                ),
                textInputAction: TextInputAction.done,
                //optional: onChanged: (s) => setState(() {}), //if you want live preview 
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StyledButton(
                  onPressed: canIncrease ? _increaseQuantity : null,
                  text: 'Add',
                  icon: Icons.add_circle,
                  backgroundColor: Colors.green,
                ),
                const SizedBox(width: 20),
                StyledButton(
                  onPressed: canDecrease ? _decreaseQuantity : null,
                  text: 'Remove',
                  icon: Icons.remove_circle,
                  backgroundColor: Colors.red,
                )
              ]
            )
          ]
        )
      )
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;
  final String? note;

  const OrderItemDisplay(this.quantity, this.itemType, {this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return Container (
      width: 400,
      height: 200,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$quantity $itemType sandwich(es): ${List.filled(quantity, '🥪').join()}',
            style: const TextStyle(color: Colors.black, fontSize: 18),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (note != null && note!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Note: $note', style: const TextStyle(color: Colors.black)),
            ),
        ],
      ),
    );
  }
}

// Compact display for top row
class OrderCompactDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderCompactDisplay(this.quantity, this.itemType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Quantity first
          Text(
            '$quantity ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // Sandwich name and emoji together
          Expanded(
            child: Text(
              '$itemType ${List.filled(quantity, '🥪').join()}',
              style: const TextStyle(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandwich Shop App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Sandwich Shop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to my shop!!'),            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class StyledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;

  const StyledButton({
    this.onPressed,
    required this.text,
    this.icon,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, //null => disabled
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
          )
        ]
      )
    );
  }
}