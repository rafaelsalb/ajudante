// ignore_for_file: non_constant_identifier_names

import 'package:ajudante/widgets/Contact.dart';
import 'package:uuid/uuid.dart';

class ContactModel {
  late String id = const Uuid().v1();
  late String name;
  late String? phone;
  late String? email;
  late String? address;

  ContactModel(
      {required this.name,
      this.phone,
      this.email,
      this.address});

  ContactModel.fromContact(Contact contact) {
    name = contact.name;
    phone = contact.phone;
    email = contact.email;
    address = contact.address;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }
}
