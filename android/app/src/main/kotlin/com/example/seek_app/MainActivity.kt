package com.example.seek_app

import io.flutter.embedding.android.FlutterFragmentActivity // ✅ Use FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() { // ✅ Extend FlutterFragmentActivity
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        ScannerHandler(this, flutterEngine.dartExecutor.binaryMessenger)
    }
}