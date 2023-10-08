import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _displayAddTaskDialog(BuildContext context) async {
    String taskTitle, taskDescription;
    DateTime dueDate;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add New Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Task Title'),
                  onChanged: (value) {
                    taskTitle = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Task Description'),
                  onChanged: (value) {
                    taskDescription = value;
                  },
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App'),
      ),
      body: Center(
        child: Text('List of tasks will appear here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
