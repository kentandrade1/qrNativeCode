import Flutter
import UIKit
import AVFoundation
import Vision

/// 📌 Implementación de la API generada por Pigeon
class ScannerHandler: NSObject, ScannerQR {
    func scanQrCode(completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.main.async {
            if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
                let scannerVC = ScannerViewController()
                scannerVC.completionHandler = { result in
                    if let code = result {
                        completion(.success(code))
                    } else {
                        completion(.failure(PigeonError(code: "SCAN_ERROR", message: "No se pudo escanear el código", details: nil)))
                    }
                }
                rootViewController.present(scannerVC, animated: true)
            } else {
                completion(.failure(PigeonError(code: "UI_ERROR", message: "No se encontró el ViewController raíz", details: nil)))
            }
        }
    }
}

/// 📌 Controlador de escaneo QR con Vision
class ScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var completionHandler: ((String?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            completionHandler?(nil)
            dismiss(animated: true)
            return
        }

        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            completionHandler?(nil)
            dismiss(animated: true)
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            completionHandler?(nil)
            dismiss(animated: true)
            return
        }

        let videoOutput = AVCaptureVideoDataOutput()
        if (captureSession.canAddOutput(videoOutput)) {
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(videoOutput)
        } else {
            completionHandler?(nil)
            dismiss(animated: true)
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        captureSession.startRunning()
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        detectBarcode(in: pixelBuffer)
    }

    private func detectBarcode(in pixelBuffer: CVPixelBuffer) {
        let request = VNDetectBarcodesRequest { request, error in
            guard error == nil else {
                print("Error en detección: \(String(describing: error))")
                return
            }

            if let results = request.results as? [VNBarcodeObservation],
               let qrCode = results.first?.payloadStringValue {
                DispatchQueue.main.async {
                    self.captureSession.stopRunning()
                    self.completionHandler?(qrCode)
                    self.dismiss(animated: true)
                }
            }
        }

        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error al procesar imagen: \(error)")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
}