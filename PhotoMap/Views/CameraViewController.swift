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

class CameraViewController: UIViewController, UINavigationControllerDelegate
{
    @IBOutlet weak var previewView: UIView!

    fileprivate let locationManager = CLLocationManager()
    fileprivate let geocoder = CLGeocoder()
    fileprivate let imagePicker = UIImagePickerController()

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
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
        let cameraMediaType = AVMediaTypeVideo

        switch AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        {
            case .authorized:
                return true
            case .notDetermined:
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
            default:
                break
        }
        return false
    }
}

// MARK: - UIImagepPickerControllerdelegate
extension CameraViewController: UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        defer
        {
            picker.dismiss(animated: true)
            tabBarController?.selectedIndex = 2
        }

        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("image is empty")
            return
        }

        locationManager.startUpdatingLocation()

        guard let location = locationManager.location else
        {
            locationManager.stopUpdatingLocation()
            print("location is empty")
            return
        }

        geocoder.reverseGeocodeLocation(location, completionHandler:
        { (placemarks, _) in
            _ = placemarks?.first
            _ = image
            // TODO: save snap object here
        })

        locationManager.stopUpdatingLocation()
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

// MARK: - CLLocationManagerDelegate
extension CameraViewController: CLLocationManagerDelegate { }
