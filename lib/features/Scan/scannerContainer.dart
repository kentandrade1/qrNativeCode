// ignore: file_names
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:seek_app/models/scanner.dart'; 

class ScannerContainer extends StatelessWidget {
  final Scan scan;
  const ScannerContainer({super.key, required this.scan});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(scan.date);
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10, top: 10, left: 10),
            padding: EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.black87,
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.black87,
                  Colors.black87,
                  Colors.black,
                ],
                begin: Alignment.topLeft, 
                end: Alignment.topRight,
              ),
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(0), 
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(
                    0,
                    4,
                  ), 
                  blurRadius: 6, 
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Descripción: ${scan.description}',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                SizedBox(height: 2),
                Text(
                  'Fecha: $formattedDate',
                  style: TextStyle(fontSize: 10, color: Colors.white54),
                ),
              ],
            ),
          ),

          // Si es ingreso
          Positioned(
            top: 0,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black12, 
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.2), 
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text(
                scan.code,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
