
import 'package:database_flutter/db/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> addStudents(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  //adding database
  final idb = await studentDB.add(value);
  value.id = idb;
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  studentDB.deleteAt(index);
}

Future<void> editStudent(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(id, value);
}
