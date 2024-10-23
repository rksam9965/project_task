import 'package:cloud_firestore/cloud_firestore.dart';
import '../datamodule/student.dart';

class StudentService {
  final CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> addStudent(Student student) async {
    try {
      await _studentCollection.add(student.toMap());
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  Future<void> updateStudent(Student student) async {
    try {
      await _studentCollection.doc(student.id).update(student.toMap());
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      await _studentCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting student: $e');
    }
  }

  Stream<List<Student>> getStudents() {
    return _studentCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Student.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<Student?> getStudentById(String id) async {
    DocumentSnapshot doc = await _studentCollection.doc(id).get();
    return doc.exists
        ? Student.fromMap(doc.data() as Map<String, dynamic>, doc.id)
        : null;
  }
}
