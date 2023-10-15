//ÖZNUR  The class appears to correctly represent a task, including its title, description, due date, and completion status.
//ÖZNUR  The default value for isCompleted is appropriate.
//ÖZNUR  The class is simple and serves a single purpose, which is to represent a task.
//ÖZNUR  The class is flexible enough to represent a variety of tasks with different properties. 
//ÖZNUR  The use of named parameters in the constructor makes it easy to create instances of this class.



class Task {
  String title;
  String description;
  DateTime? dueDateTime;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.dueDateTime,
    this.isCompleted = false, // default value
  });
}
