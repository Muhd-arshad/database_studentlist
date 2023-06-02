import 'dart:io';

import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  final String name;
  final String photo;
  final String age;
  final String place;
  final String phone;
  final int index;
  const StudentDetails(
      {super.key,
      required this.name,
      required this.photo,
      required this.age,
      required this.place,
      required this.phone,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Student Details'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 90,
                backgroundImage: FileImage(
                  File(photo),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                name[0].toUpperCase() + name.substring(1),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 90,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 90, right: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Age : $age',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Phone :$phone',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Place : $place',
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
