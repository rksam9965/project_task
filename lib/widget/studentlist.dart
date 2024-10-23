import 'package:flutter/material.dart';
import '../datamodule/student.dart';
import '../screen/studentDetailScreen.dart';
import '../service/service.dart';

class StudentList extends StatelessWidget {
  final StudentService studentService;

  StudentList({required this.studentService});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Student>>(
      stream: studentService.getStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }
        final students = snapshot.data;
        return ListView.builder(
          itemCount: students?.length ?? 0,
          itemBuilder: (context, index) {
            final student = students![index];
            return Container(
              height: 135,
              margin: EdgeInsets.only(
                  top: index == 0 ? 10 : 4), // Space between items
              child: Container(
                margin:
                    EdgeInsets.symmetric(vertical: 8.0), // Space between items
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Shadow color
                      spreadRadius: 1, // Spread radius of the shadow
                      blurRadius: 5, // Blur radius of the shadow
                      offset: Offset(0, 3), // Offset of the shadow
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      10), // Match with container's border radius
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentDetailScreen(studentId: student.id),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Padding inside the container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Student Name: ${student.name}",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 4), // Space between text lines
                        Text(
                          "Roll No: ${student.rollNumber}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
