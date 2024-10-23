import 'package:flutter/material.dart';
import '../color.dart';
import '../service/service.dart';
import '../widget/studentlist.dart';
import 'addStudent.dart';

class HomeScreen extends StatelessWidget {
  final StudentService _studentService = StudentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appGoldColor,
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
            child: Text(
              'Student List',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )),
      body: StudentList(studentService: _studentService),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddStudentScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
