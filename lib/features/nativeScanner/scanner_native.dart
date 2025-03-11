import 'package:flutter/material.dart';
import 'package:seek_app/models/scanner.dart';
import 'package:seek_app/models/user.dart';
import 'package:seek_app/scannerQR.dart';
import 'package:seek_app/services/dataBaseHelper.dart';
import 'package:seek_app/widgets/customButton.dart';
import 'package:seek_app/widgets/customDialog.dart';
import 'package:seek_app/widgets/textfieldCustom.dart';

class NativeScanner extends StatefulWidget {
  final Function updateBalance;

  const NativeScanner({super.key, required this.updateBalance});

  @override
  State<NativeScanner> createState() => _NativeScannerState();
}

// ignore: unused_element
String _qrCode = "Escanea un código";
final _descriptionController = TextEditingController();

class _NativeScannerState extends State<NativeScanner> {
  Future<void> _scanQrCode() async {
    final api = ScannerQR();
    try {
      final result = await api.scanQrCode();

      setState(() {
        _qrCode = result;
      });
      String scannedData = result;

      CustomDialog.showCustomDialog(
        // ignore: use_build_context_synchronously
        context,
        title: "¿Desea Guardar lectura?",
        content: (setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(scannedData),
              SizedBox(height: 10),
              CustomTextField(
                controller: _descriptionController,
                labelText: 'Descripción del Scanner',
                keyboardType: TextInputType.multiline,
                icon: Icons.description_outlined,
              ),
              SizedBox(height: 10),
            ],
          );
        },
        saveButtonText: "Guardar",
        onSave: () async {
          String description = _descriptionController.text;

          User? user = await DatabaseHelper().getUser();

          if (user != null) {
            Scan scan = Scan(
              code: scannedData,
              date: DateTime.now(),
              description: description,
              userId: user.id!,
            );
            await DatabaseHelper().insertScannedCode(scan);
            widget.updateBalance();
          }

          Navigator.of(
            // ignore: use_build_context_synchronously
            context,
          ).pop();
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      setState(() {
        _qrCode = "Error al escanear";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          onSave: _scanQrCode,
          saveButtonText: 'Scanner Nativo',
        ),
      ),
    );
  }
}
