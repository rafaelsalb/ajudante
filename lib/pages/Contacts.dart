import 'package:ajudante/widgets/Contact.dart';
import 'package:ajudante/widgets/ContactList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    List<Contact> contacts =
        Provider.of<ContactList>(context, listen: true).contacts;

    return Column(
      children: [
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
                  child: contacts[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
