//ÖZNUR  The code seems to correctly manage tasks, including adding, toggling completion, editing, and deleting tasks. 
//ÖZNUR  The use of notifyListeners to update the UI after changes is a good practice.
//ÖZNUR  The class is relatively well-structured and follows the single responsibility principle, focusing on managing tasks.
//ÖZNUR  There is some code repetition when adding, toggling, editing, and deleting tasks.
//ÖZNUR  The code lacks comments or documentation.
//ÖZNUR  Adding comments to describe the purpose and usage of each method would make the code more maintainable and understandable.
 



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
