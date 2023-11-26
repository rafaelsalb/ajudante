import 'package:ajudante/database.dart';
import 'package:ajudante/models/ContactModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateContactForm extends StatefulWidget {
  const CreateContactForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return CreateContactFormState();
  }
}

class CreateContactFormState extends State<CreateContactForm> {
  final _formKey = GlobalKey<CreateContactFormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
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
              Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
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
                        backgroundColor: Colors.greenAccent,
                        onPressed: () => {
                              db.createContact(
                                ContactModel(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  address: addressController.text,
                                ),
                              ),
                              nameController.text = "",
                              phoneController.text = "",
                              emailController.text = "",
                              addressController.text = "",
                              Navigator.of(context).pop(),
                            },
                        child: const Icon(Icons.add)),
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
