import 'package:flutter/material.dart';
import '../datamodule/student.dart';
import '../service/service.dart';
import 'addStudent.dart';

class StudentDetailScreen extends StatefulWidget {
  final String? studentId;

  StudentDetailScreen({this.studentId});

  @override
  _StudentDetailScreenState createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  Future<Student?>? _studentFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the future to fetch student details
    _studentFuture = StudentService().getStudentById(widget.studentId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudentScreen(
                    studentId: widget.studentId,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _confirmDelete(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<Student?>(
        future: _studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          final student = snapshot.data;
          if (student == null) {
            return Center(child: Text('Student not found'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${student.name}', style: TextStyle(fontSize: 18)),
                Text('Roll Number: ${student.rollNumber}',
                    style: TextStyle(fontSize: 18)),
                Text('Class: ${student.className}',
                    style: TextStyle(fontSize: 18)),
                Text('Email: ${student.email}', style: TextStyle(fontSize: 18)),
                Text('Contact Number: ${student.contactNumber}',
                    style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Student'),
          content: Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () {
                StudentService().deleteStudent(widget.studentId!);
                Navigator.pop(context); // Close the dialog
                Navigator.pop(context); // Go back to the list
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
