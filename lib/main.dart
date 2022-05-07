import 'package:change_notifier_example/model/ValueModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ValueModel(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Change notifier example'),
      ),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final priceController = TextEditingController();


  @override
  void initState() {
    super.initState();
    priceController.addListener(_addPriceValueModel);
  }

  void _addPriceValueModel() {
    var model = context.read<ValueModel>();
    if (priceController.text.isNotEmpty) {
      model.price =int.parse(priceController.text);
    }

  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ValueModel>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    const Text(
                      'Consumer count',
                    ),
                    Text(
                      '${model.count}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const Text(
                      'Consumer price',
                    ),
                    Text(
                      '${model.price}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const Text(
                      'Consumer result',
                    ),
                    Text(
                      '${model.result}',
                      style: Theme.of(context).textTheme.headline4,
                    ),

                  ],
                );
              }
            ),

            Padding(
              padding: const EdgeInsets.all(32),
              child: TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter a price',
                ),
              ),
            )

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
        Positioned(
        left: 30,
        bottom: 20,
        child: FloatingActionButton(
          heroTag: 'back',
          onPressed: () {
            var model = context.read<ValueModel>();
            model.decrementCounter();
          },
          child: const Icon(
            Icons.remove,
            size: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        right: 30,
        child: FloatingActionButton(
          heroTag: 'next',
          onPressed: () {
            var model = context.read<ValueModel>();
            model.incrementCounter();
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      ]
    ),
    );
  }
}
