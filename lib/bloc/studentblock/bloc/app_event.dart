part of 'app_bloc.dart';

@immutable
abstract class StudentEvent {}
class LoadingEvent extends StudentEvent {}

class AddStudentEvent extends StudentEvent {
  final String name;
  final String age;
  final String phonenumber;
  final String place;
  final String imagePath;

  AddStudentEvent(
      {required this.name,
      required this.age,
      required this.phonenumber,
      required this.place,
      required this.imagePath});
}

class UpdateStudentEvent extends StudentEvent {
  final int index;
  final String name;

  final String age;
  final String phonenumber;
  final String place;
  final String imagePath;

  UpdateStudentEvent({
    required this.index,
    required this.name,
    required this.age,
    required this.phonenumber,
    required this.place,
    required this.imagePath,
  }
  );
}
class DeleteStudentEvent extends StudentEvent{
  final int index;

  DeleteStudentEvent({required this.index});
}
