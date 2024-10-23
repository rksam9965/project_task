class Student {
  String id;
  String name;
  String rollNumber;
  String className;
  String email;
  String contactNumber;

  Student({
    required this.id,
    required this.name,
    required this.rollNumber,
    required this.className,
    required this.email,
    required this.contactNumber,
  });

  factory Student.fromMap(Map<String, dynamic> data, String documentId) {
    return Student(
      id: documentId,
      name: data['name'],
      rollNumber: data['roll_number'],
      className: data['class'],
      email: data['email'],
      contactNumber: data['contact_number'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'roll_number': rollNumber,
      'class': className,
      'email': email,
      'contact_number': contactNumber,
    };
  }
}
