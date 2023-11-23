import 'package:ajudante/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Contact extends StatelessWidget {
  late final String id;
  late String name;
  late String? phone;
  late String? email;
  late String? address;

  Contact(
      {super.key,
      required this.name,
      this.phone,
      this.email,
      this.address});
  Contact.fromMap(Map<String, dynamic> map, {super.key}) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    email = map['email'];
    address = map['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor, width: 2.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 64,
                height: 64,
                child: CircleAvatar(
                  child: Icon(Icons.question_mark),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactName(name),
                    phone != "" ? ContactInfoRow(fieldName: "Telefone", info: phone) : const SizedBox.shrink(),
                    email != "" ? ContactInfoRow(fieldName: "E-mail", info: email) : const SizedBox.shrink(),
                    address != "" ? ContactInfoRow(fieldName: "Endereço", info: address) : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ContactActionButton(
                      info: phone,
                      backgroundColor: Colors.greenAccent.shade200,
                      borderColor: Colors.greenAccent.shade100,
                      color: Colors.greenAccent.shade700,
                      icon: const Icon(Icons.call),
                    ),
                    const SizedBox.square(dimension: 4.0),
                    ContactActionButton(
                      info: email,
                      backgroundColor: Colors.grey.shade300,
                      borderColor: Colors.white,
                      color: Colors.white,
                      icon: const Icon(Icons.email),
                    ),
                    ContactDeleteButton(info: id)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ContactActionButton extends StatelessWidget {
  const ContactActionButton({
    super.key,
    required this.info,
    required this.color,
    required this.icon,
    this.action,
    required this.backgroundColor,
    required this.borderColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color color;
  final Icon icon;
  final String? info;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: borderColor),
          borderRadius: BorderRadius.circular(16.0),
          color: backgroundColor),
      child: IconButton.filled(
        color: color,
        onPressed: () {
          if (info != null) {
            print("Contacting $info");
          }
          if (action != null) {
            action!();
          }
        },
        icon: icon,
      ),
    );
  }
}

class ContactDeleteButton extends StatelessWidget {
  ContactDeleteButton({
    super.key, required this.info});

  final Color backgroundColor = Colors.red;
  final Color borderColor = Colors.red.shade800;
  final Color color = Colors.white;
  final Icon icon = Icon(Icons.remove_circle);
  final String info;

  @override
  Widget build(BuildContext context) {
    AjudanteDatabase db = Provider.of<AjudanteDatabase>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 2.0, color: borderColor),
          borderRadius: BorderRadius.circular(16.0),
          color: backgroundColor),
      child: IconButton.filled(
        color: color,
        onPressed: () {
            db.deleteContact(info);
        },
        icon: icon,
      ),
    );
  }
}

Wrap ContactName(String name) {
  return Wrap(
    spacing: 8.0,
    children: [
      Text(
        name,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Text ContactInfo(String info) {
  return Text(
    info,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
  );
}

Text ContactInfoField(String fieldName) {
  return Text(
    fieldName,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );
}

class ContactInfoRow extends StatelessWidget {
  final String fieldName;
  final String? info;

  const ContactInfoRow({super.key, required this.fieldName, this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ContactInfoField("$fieldName: "),
        ContactInfo(info != null ? info! : ""),
      ],
    );
  }
}
