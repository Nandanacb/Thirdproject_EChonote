import 'package:echo_note/lists.dart';
import 'package:echo_note/listscreen.dart';
import 'package:echo_note/tasks.dart';
import 'package:echo_note/taskscreen.dart';
import 'package:echo_note/text.dart';
import 'package:echo_note/textscreen.dart';
import 'package:flutter/material.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});
  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  bool _showicons = false;
  bool _showfab = true;

  Widget showIcons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 50),
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 13, 209, 19),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.add_task),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TaskExample()));
            },
          ),
        ),
        SizedBox(height: 20), // Add spacing between containers
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 13, 209, 19),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.check_box_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListExample()));
            },
          ),
        ),
        SizedBox(height: 20), // Add spacing between containers
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 13, 209, 19),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TextExample()));
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Echo Note",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              bottom: TabBar(tabs: [
                Text("Text"),
                Text("List"),
                Text("Task"),
              ]),
              backgroundColor: Colors.green,
            ),
            floatingActionButton: _showfab
                ? FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showicons = true;
                        _showfab = false;
                      });
                    },
                    child: Icon(Icons.add))
                : null,
            body: Stack(children: <Widget>[
              TabBarView(children: [
                TextScreen(),
                Listscreen(),
                TaskScreen(),
              ]),
              if (_showicons)
                Positioned(
                  bottom: 80, // Adjust position above FAB
                  right: 15,
                  child: showIcons(),
                ),
            ])));
  }
}
