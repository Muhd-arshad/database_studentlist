import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:image_picker/image_picker.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<PhotoSelectedEvents>((event, emit) async {
      final photo = await getPhoto();

      emit(Photoloaded(photo: photo));
    });
  }
}

Future<File?> getPhoto() async {
  final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (photo == null) {
    return null;
  } else {
    final photoTemp = File(photo.path);
    return photoTemp;
  }
}
