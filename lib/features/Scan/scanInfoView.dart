import 'package:flutter/material.dart';
import 'package:seek_app/models/scanner.dart';
import 'package:seek_app/features/Scan/scannerContainer.dart';
import 'package:seek_app/services/dataBaseHelper.dart';
import 'package:seek_app/widgets/customDialog.dart';

class ScannerInfoView extends StatefulWidget {
  final Function updateBalance;
  const ScannerInfoView({
    super.key,
    required List<Scan> scannedCodes,
    required this.updateBalance,
  }) : _scannedCodes = scannedCodes;

  final List<Scan> _scannedCodes;

  @override
  State<ScannerInfoView> createState() => _ScannerInfoViewState();
}

class _ScannerInfoViewState extends State<ScannerInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children:
                    widget._scannedCodes.map((scan) {
                      return Dismissible(
                        key: Key(scan.id.toString()),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          bool? shouldDismiss = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                title: 'Confirmar eliminación',
                                content: (setState) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '¿Está seguro de eliminar la transacción?',
                                      ),
                                    ],
                                  );
                                },
                                saveButtonText: "Eliminar",
                                onSave: () {
                                  Navigator.of(context).pop(true);
                                },
                                onCancel: () {
                                  Navigator.of(context).pop(false);
                                },
                              );
                            },
                          );
                          return shouldDismiss ?? false;
                        },
                        onDismissed: (direction) async {
                          await DatabaseHelper().deleteScannedCode(
                            scan.id!,
                            scan,
                          );
                          widget.updateBalance();
                        },
                        background: Container(
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Center(
                            child: Text(
                              "Eliminar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: ScannerContainer(scan: scan),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
