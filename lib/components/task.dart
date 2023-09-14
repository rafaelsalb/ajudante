import 'package:flutter/material.dart';

class TaskButton extends StatelessWidget {
  IconData icon = Icons.add_circle_outline;
  Color color = Colors.black;
  Color backgroundColor = Colors.black;
  Function() f = () => {};

  TaskButton(IconData icon, Color color, Color backgroundColor, Function() this.f) {
    this.icon = icon;
    this.color = color;
    this.backgroundColor = backgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                  onPressed: this.f,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(this.backgroundColor),
                    side: MaterialStatePropertyAll<BorderSide>(BorderSide(color: Colors.black54, width:2)),
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      )
                    )
                  ),
                  child: Icon(
                    this.icon,
                    color: this.color,
                  )
                );
  }
}

class Task extends StatelessWidget {

  String title = "";
  String description = "";

  void nothing() {
    return;
  }

  Task({required String title, required String description}) {
    this.title = title;
    this.description = description;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Colors.deepPurple.shade100,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(this.title),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(this.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TaskButton(Icons.check_circle, Colors.green.shade600,
                    Color.fromARGB(255, 128, 255, 128), nothing),
                TaskButton(Icons.edit_outlined, Colors.blue.shade600,
                    Colors.blue.shade200, nothing),
                TaskButton(Icons.remove_circle, Colors.red.shade600,
                    Colors.red.shade200, nothing),
              ],
            )
          ],
        ),
      ),
    );
  }
}
