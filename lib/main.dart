import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final myController = TextEditingController();
  String saludo = 'Hola';

  void _incrementCounter() {
    _counter++;
    print('_counter: ${_counter}');
    setState(() {
      _counter++;
    });
  }

  void btnGreetingOnPressed() {
/*    setState(() {
      saludo = 'Hello ' + myController.text;
    });*/
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second text field: ${text}');
  }

  void btnEditTextButtonOnClik() {
    print('Press');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(children: <Widget>[
              SizedBox(
                  width: 200,
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: const Text('Nombre'),
                    ),
                  )),
              ElevatedButton(
                  onPressed: btnGreetingOnPressed, child: const Text('Saludar'))
            ]),
            Text(saludo),
            EditTextButton(
              onClick: btnEditTextButtonOnClik,
              label: 'Nombres',
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
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

class EditTextButton extends StatelessWidget {
  const EditTextButton({required this.label, required this.onClick});

  final String label;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
          width: 200,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(label),
            ),
          )),
      ElevatedButton(onPressed: onClick, child: Text('OK'))
    ]);
  }
}
