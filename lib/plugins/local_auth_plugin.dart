import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> checkBiometrics()async{
    return await auth.canCheckBiometrics;
  }
  static Future<(bool,String)> authenticate ()async{
    try {
      final bool didAuthenticate = await auth.authenticate(
    localizedReason: 'Autenticate para continuar',
    options: const AuthenticationOptions());
    return(didAuthenticate,didAuthenticate?'Hecho':'Cancelado por usuario');
    } on PlatformException catch (e) {

      if(e.code == auth_error.notEnrolled) return (false, "No hay Biométricos enrolados");
      if(e.code == auth_error.lockedOut) return (false, "Muchos intentos fallidos");
      if(e.code == auth_error.notAvailable) return (false, "No hay Biométricos disponibles");
      if(e.code == auth_error.passcodeNotSet) return (false, "No hay un pin configurado");
      if(e.code == auth_error.permanentlyLockedOut) return (false, "Se requiere desbloquear el télefono");
      return (false,e.toString());
    }
  }
}
