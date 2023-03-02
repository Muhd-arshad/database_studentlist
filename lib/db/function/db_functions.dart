// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:database_flutter/db/model/data_model.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';


ValueNotifier<List<StudentModel>> studentLIstNotifier = ValueNotifier([]);
Future<void> addStudents(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  //adding database
  final idb= await studentDB.add(value);
  value.id =idb ;
  studentLIstNotifier.value.add(value);
  studentLIstNotifier.notifyListeners();
}
Future<void>getAllStudents()async{
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  studentLIstNotifier.value.clear();
  studentLIstNotifier.value.addAll(studentDB.values);
  studentLIstNotifier.notifyListeners();
}
Future<void>deleteStudent(int index)async{
final studentDB = await Hive.openBox<StudentModel>('Student_db');
studentDB.deleteAt(index);
getAllStudents();


}

Future<void> editStudent(int id, StudentModel value) async{
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(id, value);
  getAllStudents();
}