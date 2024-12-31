import 'package:echo_note/appwrite_service.dart';


import 'package:flutter/material.dart';

class Edittext extends StatefulWidget {
  final String id;
  final String title;
  final String content;

  const Edittext({required this.id,required this.title,required this.content});
  @override
  State<Edittext> createState() => _EdittextState();
}

class _EdittextState extends State<Edittext> {
  late AppwriteService _appwriteService;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
   titleController.text=widget.title;
    contentController.text=widget.content;
  }
 
 
  Future<void>_updateTextt() async{
    final updatedTitle=titleController.text;
    final updatedContent=contentController.text;

    if(updatedTitle.isNotEmpty && updatedContent.isNotEmpty){
      try{
      final updatedTextt=  await _appwriteService.updateTextt(
          widget.id,
          updatedTitle,
          updatedContent);
        Navigator.pop(context,updatedTextt);
      }catch (e){
        print("Error updated text:$e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Filed to update the document")));
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Edit Note",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: _updateTextt,
              icon: Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
              maxLines: 20,
              controller: contentController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  "Description",
                  style: TextStyle(color: Colors.green),
                ),
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
