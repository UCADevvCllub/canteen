import 'package:canteen/presentation/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Text('You have pushed the button this many times:'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
