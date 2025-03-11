import 'package:flutter/material.dart';
import 'package:seek_app/widgets/customButton.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget Function(StateSetter) content; 
  final String saveButtonText; 
  final Function onSave; 
  final Function onCancel; 

  const CustomDialog({super.key, 
    required this.title,
    required this.content,
    this.saveButtonText = "Guardar", 
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), 
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: content(setState), 
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            onCancel();
          },
          child: Text(
            'Cancelar',
            style: TextStyle(fontSize: 16, color: Colors.red.shade500),
          ),
        ),
        CustomButton(onSave: onSave, saveButtonText: saveButtonText),
      ],
    );
  }

  static void showCustomDialog(BuildContext context, {
    required String title,
    required Widget Function(StateSetter) content,
    String saveButtonText = "Guardar",
    required Function onSave,
    required Function onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: title,
          content: content,
          saveButtonText: saveButtonText,
          onSave: onSave,
          onCancel: onCancel,
        );
      },
    );
  }
}
