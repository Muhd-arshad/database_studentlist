import 'package:database_flutter/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'db/model/data_model.dart';

Future<void> main()async{
 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered( StudentModelAdapter().typeId)){
  Hive.registerAdapter(StudentModelAdapter());
 }
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenHome(),
    );
  }
}