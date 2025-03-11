package com.example.seek_app

import android.app.Activity
import android.content.Intent
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import io.flutter.plugin.common.BinaryMessenger
import com.journeyapps.barcodescanner.ScanContract
import com.journeyapps.barcodescanner.ScanOptions

class ScannerHandler(private val activity: Activity, messenger: BinaryMessenger) : ScannerQR {
    private lateinit var scanLauncher: ActivityResultLauncher<ScanOptions>

    init {
        ScannerQR.setUp(messenger, this) // ✅ Ensure this matches the Pigeon-generated API
        setupScanLauncher() // ✅ Initialize the QR scanner properly
    }

    private fun setupScanLauncher() {
        scanLauncher = (activity as? androidx.activity.ComponentActivity)
            ?.registerForActivityResult(ScanContract()) { result ->
                if (result.contents != null) {
                    scanQrCodeCallback?.invoke(Result.success(result.contents)) // ✅ Return the scanned QR code
                } else {
                    scanQrCodeCallback?.invoke(Result.failure(Exception("Scan canceled or failed")))
                }
            } ?: throw IllegalStateException("Activity must be a ComponentActivity")
    }

    private var scanQrCodeCallback: ((Result<String>) -> Unit)? = null

    override fun scanQrCode(callback: (Result<String>) -> Unit) {
        scanQrCodeCallback = callback
        val options = ScanOptions()
        options.setPrompt("Scanner Nativo Android")
        options.setBeepEnabled(true)
        options.setOrientationLocked(true) // Allow rotation if needed
        options.setBarcodeImageEnabled(true)

        scanLauncher.launch(options) // ✅ Start the QR code scanner
    }
}