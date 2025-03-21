import Flutter
import UIKit
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     let controller = window?.rootViewController as! FlutterViewController
        let messenger = controller.binaryMessenger
        
        let scannerHandler = ScannerHandler()
        ScannerQRSetup.setUp(binaryMessenger: messenger, api: scannerHandler)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
