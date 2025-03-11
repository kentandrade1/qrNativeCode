// ignore: file_names
import 'package:flutter/material.dart';
import 'package:seek_app/features/authentication/biometricsScreen.dart';


class MyDrawer extends StatelessWidget {
  // ignore: unused_field
  final Function(int) _onItemTapped;

  const MyDrawer({super.key, required Function(int) onItemTapped})
      : _onItemTapped = onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200, // Altura de la cabecera
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.black, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              child: Image.asset(
                'assets/logo/seek.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Spacer(), 

          ListTile(
            title: Text(''),
            trailing: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BiometricsScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
