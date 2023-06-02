import 'package:database_flutter/bloc/photoblock/bloc/photo_bloc.dart';
import 'package:database_flutter/bloc/studentblock/bloc/app_bloc.dart';
import 'package:database_flutter/screen/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'db/model/data_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
        BlocProvider(
          create: (context) => PhotoBloc(),
        ),
      ],
      child: const MaterialApp(
        home: ScreenHome(),
      ),
    );
  }
}
