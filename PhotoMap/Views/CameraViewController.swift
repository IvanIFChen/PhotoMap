//
//  CameraViewController.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/24/17.
//
//

import UIKit
import AVFoundation
import CoreLocation

class CameraViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var previewView: UIView!
    fileprivate let locationManager = CLLocationManager()

    let imagePicker = UIImagePickerController()

    override func viewDidLoad()
    {
        _ = checkCameraAuthorizationStatus()
        checkLocationAuthorizationStatus()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        openCamera()
    }

    private func checkLocationAuthorizationStatus()
    {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    private func openCamera()
    {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("This device doesn't have a camera.")
            return
        }

        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .rear
        imagePicker.cameraCaptureMode = .photo
        imagePicker.cameraFlashMode = .off
        imagePicker.delegate = self

        present(imagePicker, animated: true)

    }

    private func checkCameraAuthorizationStatus() -> Bool
    {
        var result: Bool = false
        let cameraMediaType = AVMediaTypeVideo
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: cameraMediaType)

        switch cameraAuthorizationStatus
        {
        case .denied: break
        case .authorized: result = true;  break
        case .restricted: break
        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(forMediaType: cameraMediaType)
            { granted in
                if granted
                {
                    print("Granted access to \(cameraMediaType)")
                } else
                {
                    print("Denied access to \(cameraMediaType)")
                }
            }
        }
        return result
    }
}

// MARK: - UIImagepPickerControllerdelegate
extension CameraViewController
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        defer
        {
            picker.dismiss(animated: true)
            tabBarController?.selectedIndex = 2
        }

        print(info)

        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        defer
        {
            picker.dismiss(animated: true)
            tabBarController?.selectedIndex = 2
        }

        print("did cancel")
    }
}
