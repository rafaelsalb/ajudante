import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  late String name;
  String? phone;
  String? email;
  String? address;

  Contact(
      {super.key,
      required String this.name,
      String? this.phone,
      String? email,
      String? address});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          Text(name),
        ],
      ),
    );
  }
}
