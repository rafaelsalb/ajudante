import 'package:ajudante/widgets/Contact.dart';
import 'package:ajudante/widgets/ContactList.dart';
import 'package:ajudante/widgets/CreateContactForm.dart';
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

  return Scaffold(
    appBar: AppBar(title: Text("Contatos")),
    body: Column(
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
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.deepPurple,
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return Stack(
            children: [
              CreateContactForm(),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close)),
              ),
            ],
          );
        }
      ),
      child: Icon(Icons.add), 
    ),
  );
  }
}
