import 'package:flutter/material.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Page'),
      ),
      body: const Center(
        child: Text('Это страница сохранённого контента'),
      ),
    );
  }
}