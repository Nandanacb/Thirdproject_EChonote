import 'package:appwrite/models.dart';

class Textt {
  final String id;
  final String title;
  final String content;

  Textt({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Textt.fromDocument(Document doc) {
    return Textt(
      id: doc.$id,
      title: doc.data['title'],
      content: doc.data['content'],
    );
  }
}
