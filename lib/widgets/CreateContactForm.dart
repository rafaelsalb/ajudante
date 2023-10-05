import 'package:ajudante/widgets/Contact.dart';
import 'package:ajudante/widgets/ContactList.dart';
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
                padding: EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.small(
                      onPressed: () => {
                        nameController.text = "",
                        phoneController.text = "",
                        emailController.text = "",
                        addressController.text = "",
                      },
                      child: const Icon(Icons.clear)),
                    SizedBox(width: 4.0,),
                    FloatingActionButton.small(
                      onPressed: () => {
                        Provider.of<ContactList>(context, listen: false).addContact(
                          Contact(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            address: addressController.text,
                          )),
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
