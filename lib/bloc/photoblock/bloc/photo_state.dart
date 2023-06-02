part of 'photo_bloc.dart';

@immutable
abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class Photoloaded extends PhotoState{

  final File? photo;

  Photoloaded({required this.photo});
}
