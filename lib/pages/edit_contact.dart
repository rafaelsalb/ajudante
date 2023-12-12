import 'package:ajudante/database.dart';
import 'package:ajudante/models/ContactModel.dart';
import 'package:ajudante/widgets/Contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditContactForm extends StatefulWidget {
  final String contactId;
  
  const EditContactForm({super.key, required this.contactId});

  @override
  State<EditContactForm> createState() => _EditContactFormState();
}

class _EditContactFormState extends State<EditContactForm> {
  final _formKey = GlobalKey<_EditContactFormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> getData(AjudanteDatabase db) async {
    List<Contact> contacts = await db.contacts();
    Contact contact = contacts.firstWhere((element) => element.id == widget.contactId);
    nameController.text = contact.name;
    phoneController.text = contact.phone != null ? contact.phone! : "";
    emailController.text = contact.email != null ? contact.email! : "";
    addressController.text = contact.address != null ? contact.address! : "";
  }

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
    getData(db);
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value == "") {
                    return ('Enter text');
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value == null || value == "") {
                    return ('Enter text');
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value == "") {
                    return ('Enter text');
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value == null || value == "") {
                    return ('Enter text');
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Endereço'),
              ),
              // Row(
              //   children: [
              //     hasDeadlineCheckbox,
              //     const Text('Definir prazo?'),
              //     if (hasDeadlineCheckbox.isChecked)
              //       DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                        heroTag: 'clear',
                        backgroundColor: Colors.redAccent,
                        onPressed: () => {
                              nameController.text = "",
                              phoneController.text = "",
                              emailController.text = "",
                              addressController.text = "",
                            },
                        child: const Icon(Icons.clear)),
                    const SizedBox(
                      width: 4.0,
                    ),
                    FloatingActionButton.small(
                        heroTag: 'create',
                        backgroundColor: Colors.greenAccent,
                        onPressed: () => {
                              db.updateContact(
                                 widget.contactId,
                                 nameController.text,
                                 phoneController.text,
                                 emailController.text,
                                 addressController.text,
                              ),
                              nameController.text = "",
                              phoneController.text = "",
                              emailController.text = "",
                              addressController.text = "",
                              Navigator.of(context).pop(),
                            },
                        child: const Icon(Icons.edit)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}