import 'package:bloc/bloc.dart';
import 'package:database_flutter/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';

import '../../../db/function/db_functions.dart';

part 'app_event.dart';
part 'app_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final List<StudentModel> studentData = [];

  StudentBloc() : super(IntialState()) {
    on<LoadingEvent>((event, emit) async {
     
      final studentDataFromDb = await Hive.openBox<StudentModel>('Student_db');
      studentDataFromDb.values.toList();
      studentData.clear();
      studentData.addAll(studentDataFromDb.values);
      emit(LoadingState(studentData));
    });

    on<AddStudentEvent>((event, emit) {
      StudentModel studentModel = StudentModel(
          name: event.name,
          age: event.age,
          phonenumber: event.phonenumber,
          place: event.place,
          photo: event.imagePath);
      addStudents(studentModel);
      add(LoadingEvent());
    });
    on<UpdateStudentEvent>((event, emit) {
      StudentModel studentModel = StudentModel(
          name: event.name,
          age: event.age,
          phonenumber: event.phonenumber,
          place: event.place,
          photo: event.imagePath);
      editStudent(event.index, studentModel);
      add(LoadingEvent());
    });
    on<DeleteStudentEvent>((event, emit) {
      deleteStudent(event.index);
      add(LoadingEvent());
    });
  }
}
