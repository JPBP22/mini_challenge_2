import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Pending Tasks')),
        body: ListView.builder(
          itemCount: 10, // placeholder, replace with dynamic list later
          itemBuilder: (context, index) {
            return ListTile(title: Text('Task $index'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Will implement dialog or bottom sheet
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
