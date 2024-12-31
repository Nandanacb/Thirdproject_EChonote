import 'package:echo_note/appwrite_service.dart';
import 'package:echo_note/class_text.dart';

import 'package:echo_note/edittext.dart';

import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  late AppwriteService _appwriteService;
  late List<Textt> _textt;

  @override
  void initState() {
    super.initState();
    _appwriteService = AppwriteService();
    _textt = [];
    _loadtextts();
  }

  Future<void> _loadtextts() async {
    try {
      final textts = await _appwriteService.getTextts();
      setState(() {
        _textt = textts.map((e) => Textt.fromDocument(e)).toList();
      });
    } catch (e) {
      print("Error loading text:$e");
    }
  }



  Future<void> _deleteTextt(String texttId) async {
    try {
      await _appwriteService.deleteTextt(texttId);
      _loadtextts();
    } catch (e) {
      print('Error deleting text:$e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 7,
                      mainAxisSpacing: 7),
                  itemCount: _textt.length,
                  itemBuilder: (context, index) {
                    final textts = _textt[index];
                    return Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 87, 115, 240)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(textts.title),
                                Spacer(),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'Edit') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Edittext(id: textts.id,
                                                      title: textts.title,
                                                      content: textts.content,)));
                                    } else if (value == 'Delete') {
                                      _deleteTextt(textts.id);
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                        value: "Edit", child: Text("Edit")),
                                    PopupMenuItem(
                                        value: 'Delete', child: Text('delete')),
                                  ],
                                )
                              ],
                            ),
                            Text(textts.content),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
