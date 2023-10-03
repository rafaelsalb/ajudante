import 'package:ajudante/widgets/Contact.dart';
import 'package:flutter/material.dart';

class ContactList extends ChangeNotifier {
  final List<Contact> _contacts = <Contact>[Contact(name: "fafb")];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }
}
