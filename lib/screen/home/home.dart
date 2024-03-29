import 'dart:io';

import 'package:database_flutter/bloc/studentblock/bloc/app_bloc.dart';
import 'package:database_flutter/screen/add_list.dart';
import 'package:database_flutter/screen/std_details.dart';
import 'package:database_flutter/screen/std_edit.dart';
import 'package:database_flutter/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../db/model/data_model.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(LoadingEvent());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchStudent());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            List<StudentModel> studentList = state.studentList;
            return ListView.separated(
              itemBuilder: (context, index) {
                final data = studentList[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentDetails(
                          photo: data.photo,
                          age: data.age,
                          name: data.name,
                          phone: data.phonenumber,
                          place: data.place,
                          index: index,
                        ),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      File(data.photo),
                    ),
                  ),
                  title: Text(data.name),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudents(
                                name: data.name,
                                age: data.age,
                                image: data.photo,
                                phone: data.phonenumber,
                                place: data.place,
                                index: index,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx1) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: const Text(
                                  
                                  'Are You Sure',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  'Delete ${data.name.toUpperCase()} ?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                     BlocProvider.of<StudentBloc>(context).add(DeleteStudentEvent(index: index));
                                      Navigator.of(ctx1).pop();
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No..',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 1,
                  color: Colors.grey,
                );
              },
              itemCount: studentList.length,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Details'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AddStudents(),
            ),
          );
        },
      ),
    );
  }
}
