import 'package:ajudante/widgets/color_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  const About({super.key});

  String get title => "Sobre";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Sobre")),
        body: Column(
          children: [
            Row(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.yellow.shade500,
                  child: Icon(Icons.light_mode),
                  onPressed: () {
                    Provider.of<ColorMode>(context, listen: false)
                        .switchColorScheme();
                  },
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text("Alternar modo claro/escuro",
                    style: TextStyle(fontSize: 16)),
              ],
            )
          ],
        ));
  }
}
