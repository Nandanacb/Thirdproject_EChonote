import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AppwriteService {
  late Client client;
  late Databases databases;

  static const endpoint = "https://cloud.appwrite.io/v1";
  static const projectId = "674d5517000114a2fc41";
  static const databaseId = "674d55750023577ccc13";
  static const taskcollectionId = "674d5596002c7f25de81";
  static const textscollectionId = "6750010100365fe9b5ad";
  static const listcollectionId = "674d558d000bd8dc4222";

  AppwriteService() {
    client = Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases = Databases(client);
  }
  //task screen
  Future<List<Document>> getTasks() async {
    try {
      final result = await databases.listDocuments(
          databaseId: databaseId, collectionId: taskcollectionId);
      return result.documents;
    } catch (e) {
      print('Error loading notes:$e');
      rethrow;
    }
  }

  Future<Document> addTask(
      String title, String description, String Date, String Time) async {
    try {
      final documentId = ID.unique();

      final result = await databases.createDocument(
        databaseId: databaseId,
        collectionId: taskcollectionId,
        data: {
          'title': title,
          'description': description,
          'Date': Date,
          'Time': Time,
        },
        documentId: documentId,
      );
      return result;
    } catch (e) {
      print('Error creating note:$e');
      rethrow;
    }
  }

  Future<Document> updateTask(
      String taskId, String title, String description) async {
    try {
      final result = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: taskcollectionId,
        documentId: taskId,
        data: {
          'title': title,
          'description': description,
        },
      );
      return result;
    } catch (e) {
      print('Error updating task :$e');
      rethrow;
    }
  }

  Future<void> deleteTask(String documentId) async {
    try {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: taskcollectionId,
        documentId: documentId,
      );
    } catch (e) {
      print('Error deleting note:$e');
      rethrow;
    }
  }
//list screen

  Future<List<Document>> getLissts() async {
    try {
      final result = await databases.listDocuments(
          databaseId: databaseId, collectionId: listcollectionId);
      return result.documents;
    } catch (e) {
      print('Error loading notes:$e');
      rethrow;
    }
  }

  Future<Document> addLisst(String title, List<String> addlist) async {
    try {
      final documentId = ID.unique();
      final response = await databases.createDocument(
        databaseId: databaseId,
        collectionId: listcollectionId,
        data: {
          'title': title,
          'addlist': addlist, // Pass the entire list of strings
        },
        documentId: documentId,
      );
      print('Document created with title: ${response.data['title']}');
      print('List data:${response.data['addlist']}');
      return response;
    } catch (e) {
      print('Error creating list: $e');
      rethrow;
    }
  }

  Future<Document> updateLisst(
    String lisstId, String title, List<String> addList) async {
  try {
    final result = await databases.updateDocument(
      databaseId: databaseId,
      collectionId: listcollectionId,
      documentId: lisstId,
      data: {
        'title': title,
        'addlist': addList,
      },
    );
    return result;
  } catch (e) {
    print('Error updating list :$e');
    rethrow;
  }
}

Future<void> deleteLisst(String LisstId) async {
  try {
    await databases.deleteDocument(
      databaseId: databaseId,
      collectionId: listcollectionId,
      documentId: LisstId,
    );
    print('List deleted successfully');
  } catch (e) {
    print('Error deleting list: $e');
    rethrow;
  }
}
//text screen

  Future<List<Document>> getTextts() async {
    try {
      final result = await databases.listDocuments(
          databaseId: databaseId, collectionId: textscollectionId);
      return result.documents;
    } catch (e) {
      print('Error loading notes:$e');
      rethrow;
    }
  }

  Future<Document> addTextt(String title, String content) async {
    try {
      final documentId = ID.unique();

      final result = await databases.createDocument(
        databaseId: databaseId,
        collectionId: textscollectionId,
        data: {
          'title': title,
          'content': content,
        },
        documentId: documentId,
      );
      print('Created document with ID: ${result.$id}');
      return result;
    } catch (e) {
      print('Error creating note:$e');
      rethrow;
    }
  }

  Future<Document> updateTextt(
      String texttId, String title, String content) async {
    try {
      final result = await databases.updateDocument(
        databaseId: databaseId,
        collectionId: textscollectionId,
        documentId: texttId,
        data: {
          'title': title,
          'content': content,
        },
      );
      return result;
    } catch (e) {
      print('Error updating textt :$e');
      rethrow;
    }
  }

  Future<void> deleteTextt(String documentId) async {
    try {
      await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: textscollectionId,
        documentId: documentId,
      );
    } catch (e) {
      print('Error deleting note:$e');
      rethrow;
    }
  }
}
