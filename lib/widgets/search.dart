import 'dart:io';

import 'package:database_flutter/db/function/db_functions.dart';
import 'package:database_flutter/db/model/data_model.dart';
import 'package:database_flutter/screen/std_details.dart';
import 'package:flutter/material.dart';

class SearchStudent extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentLIstNotifier,
      builder: (BuildContext context, List<StudentModel> studentlist,
          Widget? child) {
        return ListView.builder(
            itemBuilder: (context, index) {
              final data = studentlist[index];
              if (data.name
                  
                  .contains(query.trim())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetails(
                              name: data.name,
                              photo: data.photo,
                              age: data.age,
                              place: data.place,
                              phone: data.phonenumber,
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
                    ),
                    const Divider()
                  ],
                );
              } else {
                return const Text('');
              }
            },
            itemCount: studentlist.length);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentLIstNotifier,
      builder: (BuildContext context, List<StudentModel> studentlist,
          Widget? child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            var data = studentlist[index];
            if ( data.name.contains(query.trim())) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetails(
                              name: data.name,
                              age: data.age,
                              phone: data.phonenumber,
                              place: data.place,
                              photo: data.photo,
                              index: index,
                            ),
                          ));
                    },
                    leading: CircleAvatar(
                      backgroundImage: FileImage(File(data.photo)),
                      radius: 20,
                    ),
                    title: Text(data.name),
                  ),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: studentlist.length,
        );
      },
    );
  }
}
