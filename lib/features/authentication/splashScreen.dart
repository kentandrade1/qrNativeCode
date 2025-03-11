import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_app/features/home/homeScreen.dart';
import 'package:seek_app/features/authentication/userNameScreen.dart';
import 'package:seek_app/services/user_cubit.dart'; 

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..checkUser(), 
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.userExists) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            } else if (state.status == UserStatus.userNotFound) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => UsernameScreen()),
              );
            } else if (state.status == UserStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state.status == UserStatus.initial || state.status == UserStatus.userNotFound) {
              return Center(child: CircularProgressIndicator());
            }
            return SizedBox.shrink();  
          },
        ),
      ),
    );
  }
}
