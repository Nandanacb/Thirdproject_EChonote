import 'package:echo_note/appwrite_service.dart';



import 'package:flutter/material.dart';

class Edittask extends StatefulWidget {
  final String id;
  final String title;
  final String description;

  const Edittask(
      {required this.id, required this.title, required this.description});

  @override
  State<Edittask> createState() => _EdittaskState();
}

class _EdittaskState extends State<Edittask> {
  late AppwriteService _appwriteService;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final DateTime datetime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    titleController.text=widget.title;
    descriptionController.text=widget.description;
  
   
  }



  Future<void>_updateTask() async{
    final updatedTitle=titleController.text;
    final updatedDescription=descriptionController.text;

    if(updatedTitle.isNotEmpty && updatedDescription.isNotEmpty){
      try{
      final updatedTask=  await _appwriteService.updateTask(
          widget.id,
          updatedTitle,
          updatedDescription);
        Navigator.pop(context,updatedTask);
      }catch (e){
        print("Error updated task:$e");
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Edit Task",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: _updateTask,
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
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 20,
              controller: descriptionController,
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
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Text(
                  "${datetime.day.toString()}/${datetime.month.toString()}/${datetime.year.toString()}",
                  style: TextStyle(color: Colors.green),
                ),
                Spacer(),
                Text(
                  "${datetime.hour.toString()}/${datetime.minute.toString()}",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
