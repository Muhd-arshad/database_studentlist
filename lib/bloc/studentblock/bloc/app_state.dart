part of 'app_bloc.dart';


abstract class StudentState {

  List<StudentModel> studentList =[];

 StudentState({required this.studentList});
}

class IntialState extends StudentState{
  IntialState() :super(studentList: []);

}

class LoadingState extends StudentState{
  LoadingState(List<StudentModel> studentList) : super(studentList: studentList); 
}
class StudentAddList extends StudentState{
  StudentAddList(List<StudentModel>studentList):super(studentList: studentList);

}
class StudentViewState extends StudentState{
  StudentViewState(List<StudentModel> studentList) : super(studentList: studentList);
}
class StudentSearchState extends StudentState{
  StudentSearchState(List<StudentModel> studentList) : super(studentList: studentList);
}