//ÖZNUR  The code appears to produce the expected output, displaying completed tasks.
//ÖZNUR  The code is relatively simple and focused, which is good for a page that displays completed tasks.
//ÖZNUR The code should handle completed tasks efficiently, 
//ÖZNUR  ..but it doesn't appear to have any special considerations for handling a large number of tasks.
//ÖZNUR  This code is not intended for extensive user interaction but is flexible enough for its purpose.
//ÖZNUR  The code follows Dart best practices, including the use of the provider package for state management.



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_model.dart';
import 'task_provider.dart';

class CompletedTasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    var completedTasks = taskProvider.tasks.where((t) => t.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          Task task = completedTasks[index];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
          );
        },
      ),
    );
  }
}
