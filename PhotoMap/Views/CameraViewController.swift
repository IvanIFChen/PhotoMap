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

        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else
        {
            print("something is wrong with image")
            return
        }

        locationManager.startUpdatingLocation()

        guard let location = locationManager.location else
        {
            locationManager.stopUpdatingLocation()
            print("location is empty")
            return
        }

        // TODO: handle fail case
        geocoder.reverseGeocodeLocation(location, completionHandler:
        { (placemarks, _) in
            if let placemark = placemarks?.first
            {
                guard
                    let addressDictionary = placemark.addressDictionary,
                    // TODO: addressDictionary is deprecated
                    // see: https://developer.apple.com/documentation/corelocation/clplacemark/1423605-addressdictionary
                    let formattedAddressLines = addressDictionary["FormattedAddressLines"] as? [String]
                    else { return }
                self.saveSnap(snap: Snap.init(image: image,
                                              latitude: location.coordinate.latitude,
                                               longitude: location.coordinate.longitude,
                                               address: formattedAddressLines[0] + formattedAddressLines[1]))
            }
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

// MARK: - CoreData
extension CameraViewController
{
    // TODO: not in main thread
    fileprivate func saveSnap(snap: Snap)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        // TODO: save thumbnail in a different contianer but have relationship with the full res image
        // see: https://stackoverflow.com/questions/27995955/saving-picked-image-to-coredata
        let snapData = SnapData(context: appDelegate.persistentContainer.viewContext)
        guard let imageData = UIImageJPEGRepresentation(snap.image, 1.0) as NSData? else { return }
        snapData.image = imageData
        snapData.latitude = snap.latitude
        snapData.longitude = snap.longitude
        // TODO: find a way to save [String]
        // see: https://coderwall.com/p/mx_wmq/how-to-save-a-nsarray-nsmutablearray-in-core-data
        snapData.address = snap.address

        appDelegate.saveContext()
    }
}
