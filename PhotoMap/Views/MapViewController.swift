//
//  MapViewController.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/24/17.
//
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!
    fileprivate var locationManager: CLLocationManager = CLLocationManager()

    fileprivate var snapData: [SnapData] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()

        locationManager.delegate = self

        mapView.showsCompass = true
        mapView.showsUserLocation = true

        centerToCurrentLocation()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)

        snapData = AppDelegate.updateSnapData()

        mapView.addAnnotations(snapData.map
        { snap in
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: snap.latitude, longitude: snap.longitude)
            pointAnnotation.title = snap.address
            return pointAnnotation
        })
    }

    private func centerToCurrentLocation()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.first else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        mapView.setRegion(coordinateRegion, animated: true)

        locationManager.stopUpdatingLocation()
    }
}
