/*
* ========== Ostad Flutter Batch-10 Live Test ==========
* Live Test-02
* Name: Mohammad Monir Hossain
* Email: monir.nub.cse996@gmail.com
* Phone: 01521439480
* */

import 'package:flutter/material.dart';

void main() {
  runApp(ContactApp());
}

class ContactApp extends StatelessWidget {
  const ContactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Contact {
  final String name;
  final String number;

  Contact({required this.name, required this.number});
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  List<Contact> contacts = [];

  void addContact() {
    String name = nameController.text.trim();
    String number = numberController.text.trim();

    if (name.isNotEmpty && number.isNotEmpty) {
      setState(() {
        contacts.add(Contact(name: name, number: number));
        nameController.clear();
        numberController.clear();
      });
    }
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmation"),
        content: Text("Are you sure for Delete?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.close),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                contacts.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget buildContactTile(Contact contact, int index) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(contact.name, style: TextStyle(color: Colors.red)),
      subtitle: Text(contact.number),
      trailing: Icon(Icons.phone, color: Colors.blue),
      onLongPress: () => confirmDelete(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Contact List'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: InputDecoration(labelText: 'Number', border: OutlineInputBorder(),  counterText: ''),

            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addContact,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                child: Text('Add', style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) =>
                    buildContactTile(contacts[index], index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
