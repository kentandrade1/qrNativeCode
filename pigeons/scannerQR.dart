import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class ScannerQR {
  @async
  String scanQrCode(); 
}