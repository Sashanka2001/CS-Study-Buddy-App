import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _subjectCodeController = TextEditingController();

  Future<void> saveSubject() async {
    String name = _subjectNameController.text.trim();
    String code = _subjectCodeController.text.trim();

    if (name.isEmpty || code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('subjects').add({
        'subjectName': name,
        'subjectCode': code,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Subject saved to Firestore!')),
      );

      _subjectNameController.clear();
      _subjectCodeController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error saving subject: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Subject')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _subjectNameController,
              decoration: InputDecoration(labelText: 'Subject Name'),
            ),
            TextField(
              controller: _subjectCodeController,
              decoration: InputDecoration(labelText: 'Subject Code'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveSubject,
              child: const Text('Save to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}
