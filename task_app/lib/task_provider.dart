import 'package:flutter/foundation.dart';
import 'task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

    void addTask(Task newTask) {
    _tasks.add(newTask);
    notifyListeners();
    }

    void toggleCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();  // This will refresh the UI
    }

    void editTask(Task oldTask, Task newTask) {
    int index = tasks.indexOf(oldTask);
    if (index != -1) {
        tasks[index] = newTask;
        notifyListeners();
        }
    }

    void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
    }
}
