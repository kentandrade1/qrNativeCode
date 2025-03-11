// ignore: file_names
import 'package:flutter/material.dart';
import 'package:seek_app/features/home/homeScreen.dart';
import 'package:seek_app/models/user.dart';
import 'package:seek_app/services/dataBaseHelper.dart';
import 'package:seek_app/widgets/customButton.dart';
import 'package:seek_app/widgets/textfieldCustom.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UsernameScreenState createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _usernameController = TextEditingController();

  _saveUsername() async {
    String username = _usernameController.text;
    if (username.isNotEmpty) {
      try {
        User user = User(username: username);
        await DatabaseHelper().insertUser(user);
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      // ignore: empty_catches
      } catch (e) {
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor ingrese un nombre')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [Colors.black, Colors.black87,Colors.black87,Colors.black],
          begin: Alignment.topLeft, // Dirección inicial
          end: Alignment.topRight, // Dirección final
        ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                CustomTextField(controller: _usernameController, labelText: 'Nombre de usuario', keyboardType: TextInputType.text,icon: Icons.person,),
                SizedBox(height: 20),
                CustomButton(onSave: _saveUsername, saveButtonText: 'Guardar Nombre'),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 