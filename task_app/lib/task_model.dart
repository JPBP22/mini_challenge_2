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
