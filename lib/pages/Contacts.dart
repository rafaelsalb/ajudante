import 'package:ajudante/database.dart';
import 'package:ajudante/widgets/Contact.dart';
import 'package:ajudante/widgets/CreateContactForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ContactsPageState();
  }
}

class ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = <Contact>[];
  var _context;

  Future<void> updateContacts() async {
    var _contacts = await Provider.of<AjudanteDatabase>(context, listen: false).contacts();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  void dispose() {
    _context.removeListener(updateContacts);
    super.dispose();
  }

  @override
  void initState() {
    updateContacts();
    _context = context.read<AjudanteDatabase>();
    _context.addListener(updateContacts);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contatos")),
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
                  const CreateContactForm(),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: FloatingActionButton(
                        backgroundColor: Colors.deepPurple,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close)),
                  ),
                ],
              );
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
