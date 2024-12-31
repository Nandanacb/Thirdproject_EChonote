import 'package:appwrite/models.dart';

class Lisst {
  final String id;
  final String title;
  final List<String> addlist;  // Change from String to List<String>

  Lisst({
    required this.id,
    required this.title,
    required this.addlist,
  });

  factory Lisst.fromDocument(Document doc) {
    // Ensure the 'addlist' field is a list
    return Lisst(
      id: doc.$id,
      title: doc.data['title'],
      addlist: List<String>.from(doc.data['addlist'] ?? []),  // Convert 'addlist' to List<String>
    );
  }
}
