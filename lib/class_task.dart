import 'package:appwrite/models.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String Date;
  final String Time;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.Date,
    required this.Time,
  });

  factory Task.fromDocument(Document doc) {
    return Task(
      id: doc.$id,
      title: doc.data['title'],
      description: doc.data['description'],
      Date: doc.data['Date'],
      Time: doc.data['Time'],
    );
  }
}
