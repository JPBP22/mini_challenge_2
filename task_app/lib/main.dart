//ÖZNUR  Variable and function names are mostly descriptive and consistent with Dart's naming conventions.
//ÖZNUR  The code is properly indented and formatted for clarity.
//ÖZNUR  The code includes comments explaining the purpose of various sections and functions.
//ÖZNUR  They add value by providing context and clarifying the code.
//ÖZNUR  The code seems to handle basic edge cases, such as null values for selectedDate and selectedTime.
//ÖZNUR  The code is modular, with different parts separated into functions and classes..
//ÖZNUR  Each function serves a specific purpose
//ÖZNUR  Some parts of the code could be refactored to reduce duplication. 
//ÖZNUR  For example, the task creation dialog could be extracted into a separate function to reduce redundancy.
//ÖZNUR  The code is relatively flexible and allows for easy addition and editing of tasks.




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_model.dart';
import 'task_provider.dart';
import 'completed_task_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeManager(),
    );
  }
}

class HomeManager extends StatefulWidget {
  @override
  _HomeManagerState createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), CompletedTasksPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<void> _displayAddTaskDialog(BuildContext context) async {
    String taskTitle = '', taskDescription = '';
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

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
              ElevatedButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                },
                child: Text('Pick a due date'),
              ),
              ElevatedButton(
                onPressed: () async {
                  selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
                child: Text('Pick a due time'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                DateTime? dueDateTime;
                if (selectedDate != null && selectedTime != null) {
                  dueDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );
                }
                Provider.of<TaskProvider>(context, listen: false).addTask(
                  Task(
                      title: taskTitle,
                      description: taskDescription,
                      dueDateTime: dueDateTime),
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _displayEditTaskDialog(BuildContext context, Task oldTask) async {
    String taskTitle = oldTask.title;
    String taskDescription = oldTask.description;
    DateTime? selectedDate = oldTask.dueDateTime;
    TimeOfDay? selectedTime;

    if (selectedDate != null) {
      selectedTime = TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute);
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Title'),
                onChanged: (value) {
                  taskTitle = value;
                },
                controller: TextEditingController(text: oldTask.title),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Task Description'),
                onChanged: (value) {
                  taskDescription = value;
                },
                controller: TextEditingController(text: oldTask.description),
              ),
              ElevatedButton(
                onPressed: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2101),
                  );
                },
                child: Text('Pick a due date'),
              ),
              ElevatedButton(
                onPressed: () async {
                  selectedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                  );
                },
                child: Text('Pick a due time'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Task newTask = Task(
                  title: taskTitle,
                  description: taskDescription,
                  dueDateTime: selectedDate,
                );
                Provider.of<TaskProvider>(context, listen: false).editTask(oldTask, newTask);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Task App'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompletedTasksPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          Task task = taskProvider.tasks[index];
          String dueInfo = "";
          if (task.dueDateTime != null) {
            dueInfo = task.dueDateTime!.toLocal().toString();
          }
          return GestureDetector(
            onTap: () => _displayEditTaskDialog(context, task),
            child: ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (bool? value) {
                  taskProvider.toggleCompletion(task);
                },
              ),
              title: Text(task.title),
              subtitle: Text('${task.description}\nDue: $dueInfo'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  taskProvider.deleteTask(task);
                },
              ),
            ),
          );
        },
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
