import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_app/features/authentication/biometricsScreen.dart';

import 'package:seek_app/services/biometrics_cubits.dart';
import 'package:seek_app/services/user_cubit.dart';  // Importa el LocalAuthCubit

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seek App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MultiBlocProvider( 
        providers: [
          BlocProvider(create: (context) => UserCubit()),
          BlocProvider(create: (context) => LocalAuthCubit()), 
        ],
        child: BiometricsScreen(),  
      ),
    );
  }
}
