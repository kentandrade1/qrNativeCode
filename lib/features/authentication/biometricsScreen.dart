import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek_app/features/authentication/splashScreen.dart';
import 'package:seek_app/services/biometrics_cubits.dart';

class BiometricsScreen extends StatelessWidget {
  const BiometricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalAuthCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocConsumer<LocalAuthCubit, LocalAuthState>(
                listener: (context, state) {
                  if (state.status == LocalAuthStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }

                  // Si la autenticación fue exitosa, navega a SplashScreen
                  if (state.status == LocalAuthStatus.authenticated) {
                    // Navegación con pushReplacement
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      Text('Autenticate', style: TextStyle(color: Colors.white),),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () {
                          context.read<LocalAuthCubit>().authenticateUser();
                        },
                        child: Icon(
                          Icons.fingerprint, 
                          size: 100.0, 
                          color: Colors.grey[600], 
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
