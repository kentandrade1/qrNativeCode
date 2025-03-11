
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onSave,
    required this.saveButtonText,
  });

  final Function onSave;
  final String saveButtonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onSave(); // Ejecuta la función cuando se presiona "Guardar"
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent.shade700,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        saveButtonText,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
