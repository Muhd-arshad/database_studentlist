part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent {}

class PhotoSelectedEvents extends PhotoEvent {}

class PhotoDeletedEvent extends PhotoEvent {}
