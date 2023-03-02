import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:database_flutter/screen/home/home.dart';
import 'package:flutter/material.dart';

import '../db/function/db_functions.dart';
import '../db/model/data_model.dart';

// ignore: must_be_immutable
class EditStudents extends StatefulWidget {
  String image;
  final String name;
  final String age;
  final String place;
  final String phone;
  final int index;
  EditStudents(
      {super.key,
      required this.image,
      required this.name,
      required this.age,
      required this.place,
      required this.phone,
      required this.index});

  @override
  State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {
  TextEditingController nameController = TextEditingController();

  TextEditingController ageCOntroller = TextEditingController();

  TextEditingController placeCOntroller = TextEditingController();

  TextEditingController phoneNumberCOntroller = TextEditingController();

  bool image = true;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageCOntroller = TextEditingController(text: widget.age);
    phoneNumberCOntroller = TextEditingController(text: widget.phone);
    placeCOntroller = TextEditingController(text: widget.place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Edit Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: image == true
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(
                            File(widget.image),
                          ),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(_photo!.path)),
                        )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  onChangeImage();
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit image'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Student Name',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
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
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: placeCOntroller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Place',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  onEditButtonClicked();
                },
                child: const Text('submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onEditButtonClicked() async {
    final studentmodel = StudentModel(
         photo: _photo == null ? widget.image : _photo!.path,
        name: nameController.text.trim(),
        age: ageCOntroller.text.trim(),
        phonenumber: phoneNumberCOntroller.text.trim(),
        place: placeCOntroller.text.trim());
    final eName = nameController.text;
    final eAge = ageCOntroller.text;
    final ephone = phoneNumberCOntroller.text;
    final ePlace = placeCOntroller.text;
    if (eName.isEmpty || eAge.isEmpty || ephone.isEmpty || ePlace.isEmpty) {
      showSnackbarMessage(context);
    } else {
      editStudent(widget.index, studentmodel);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin:const EdgeInsets.all(30),
          content: Text('${nameController.text} updated'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ScreenHome(),
        ),
      );
    }
  }

  File? _photo;
  Future<void> onChangeImage() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final phototemp = File(photo.path);
      setState(() {
        _photo = phototemp;
        image = false;
      });
    }
  }
}

Future<void> showSnackbarMessage(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      content: Text('Items are required')));
}
