import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:seek_app/models/scanner.dart';
import 'package:seek_app/models/user.dart';
import 'package:seek_app/services/dataBaseHelper.dart';
import 'package:seek_app/widgets/customDialog.dart';
import 'package:seek_app/widgets/textfieldCustom.dart';

class MobileScannerSimple extends StatefulWidget {
  final Function updateBalance;
  const MobileScannerSimple({super.key, required this.updateBalance});

  @override
  State<MobileScannerSimple> createState() => _MobileScannerSimpleState();
}

class _MobileScannerSimpleState extends State<MobileScannerSimple> {
  Barcode? _barcode;
  bool _scanned = false;
  late MobileScannerController _scannerController;
  final _descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scannerController = MobileScannerController();
  }

  @override
  void dispose() {
    _scannerController
        .dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (_scanned) return;
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        _scanned = true;
      });

      if (_barcode != null) {
        String scannedData = _barcode!.displayValue ?? 'No display value.';


        CustomDialog.showCustomDialog(
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
                  icon:
                      Icons
                          .description_outlined, 
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
            setState(() {
              _scanned = false;
            });

            Navigator.of(
              // ignore: use_build_context_synchronously
              context,
            ).pop(); 
          }, 
          onCancel: () {
             setState(() {
              _scanned = false;
            });
            Navigator.of(context).pop(); 
            
          },
        );
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: _scannerController,
            onDetect: _handleBarcode,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(0),
              ),
              width: 300,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2),
                        left: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    width: 50,
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 2),
                        right: BorderSide(color: Colors.black, width: 2),
                        bottom: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          // Imagen centrada en el cuadrado
          Align(
            alignment: Alignment.center,
            child: Image.asset('assets/logo/seek.jpg', width: 50, height: 50),
          ),
        ],
      ),
    );
  }
}
