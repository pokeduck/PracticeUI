//
// BarcodeVC.swift
//
// Created by Ben for PracticeUI on 2021/2/24.
// Copyright © 2021 Alien. All rights reserved.
//

import AVFoundation
import RxCocoa
import RxSwift
import UIKit

class BarcodeVC: UIViewController {
    let bag = DisposeBag()
    let store = BarcodeSettingStore.shared
    let camera = AVCaptureDevice.default(for: .video)
    let metaOutput = AVCaptureMetadataOutput()
    var error: NSError?
    let session = AVCaptureSession()
    lazy var cameraInput: AVCaptureDeviceInput = {
        let input = try! AVCaptureDeviceInput(device: camera!)
        return input
    }()

    func start() {
        session.addInput(cameraInput)

        metaOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        session.addOutput(metaOutput)

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        view.layer.addSublayer(previewLayer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Barcode"

        start()
        let item = UIBarButtonItem(barButtonSystemItem: .camera, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.setRightBarButton(item, animated: false)
        item.rx.tap.bind(onNext: { _ in
            self.navigationController?.pushViewController(BarcodeTypeSettingVC())
        }).disposed(by: bag)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        metaOutput.metadataObjectTypes = store.avaiableTypes()
        session.startRunning()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        session.stopRunning()
    }
}

extension BarcodeVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        output.metadataOutputRectConverted(fromOutputRect: view.frame)
        metadataObjects.forEach { metaObj in
            if let barcode = metaObj as? AVMetadataMachineReadableCodeObject {
                print("Code:\(barcode.stringValue ?? "Nan")")
                print("Type:\(metaObj.type.rawValue)")
                session.stopRunning()
                let alert = UIAlertController(title: metaObj.type.rawValue, message: "\(barcode.stringValue ?? "Nan")\n Rect:\(output.rectOfInterest)")
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    self.session.startRunning()
                }))

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
