import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/textscreen.dart';
import 'package:flutter/material.dart';

class TextExample extends StatefulWidget {
  @override
  State<TextExample> createState() => _TextExampleState();
}

class _TextExampleState extends State<TextExample> {
  
  late AppwriteService _appwriteService;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
  }

  Future<void> _loadtextts() async {
    try {
      setState(() {
      });
    } catch (e) {
      print('Title is empty');
    }
  }


  Future<void> _addTextt() async {
    final title = titleController.text;
    final content = contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      try {
        await _appwriteService.addTextt(title, content);
        titleController.clear();
        contentController.clear();
        _loadtextts();
      } catch (e) {
        print('Error adding text:$e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Add New Note",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TextScreen()));
                },
                icon: IconButton(
                  onPressed: _addTextt,
                  icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ))),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "Title",
                    style: TextStyle(color: Colors.green),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 22,
              controller: contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Content",
                  style: TextStyle(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
          ]),
        ));
  }
}
