
import 'dart:async';
import 'dart:io';

import 'package:database_flutter/bloc/studentblock/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photoblock/bloc/photo_bloc.dart';

class AddStudents extends StatefulWidget {
   const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  TextEditingController nameController = TextEditingController();

  TextEditingController ageCOntroller = TextEditingController();

  TextEditingController placeCOntroller = TextEditingController();

  TextEditingController phoneNumberCOntroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: BlocBuilder<PhotoBloc, PhotoState>(
                      builder: (context, state) {
                        if (state is Photoloaded) {
                          photo = state.photo;
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(
                              File(state.photo!.path),
                            ),
                          );
                        }
                        return const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://static.toiimg.com/thumb/resizemode-4,msid-76729750,imgsize-249247,width-720/76729750.jpg'),
                          radius: 60,
                        );
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                   BlocProvider.of<PhotoBloc>(context).add(PhotoSelectedEvents());
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Add Image'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Student Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: ageCOntroller,
                  maxLength: 2,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Age',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: phoneNumberCOntroller,
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone number is required';
                    } else if (value.length < 10) {
                      return 'Invalid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: placeCOntroller,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Place',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Place is required';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (photo != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text('${nameController.text} Added'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                        onAddStudentButtonClicked();
                      } else {
                        imageSnackBar(context);
                      }
                    }
                  },
                  child: const Text('submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = nameController.text.trim();
    final age = ageCOntroller.text.trim();
    final phone = phoneNumberCOntroller.text.trim();
    final place = placeCOntroller.text.trim();

    // final studentAdd = StudentModel(
    //     name: name,
    //     age: age,
    //     phonenumber: phone,
    //     place: place,
    //     photo: userphoto!.path);
    // addStudents(studentAdd);
    Navigator.of(context).pop();
    BlocProvider.of<StudentBloc>(context).add(
      AddStudentEvent(
        name: name,
        age: age,
        phonenumber: phone,
        place: place,
        imagePath: photo!.path,
      ),
    );
  }

  // File? userphoto;
  Future<void> imageSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        content: Text('Add image'),
      ),
    );
  }
}
