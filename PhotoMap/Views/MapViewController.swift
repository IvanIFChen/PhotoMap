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

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // CORE DATA TEST CDOE

//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
//        {
//            return
//        }

//        let context = appDelegate.persistentContainer.viewContext
//
//        let snap1 = SnapData(context: context)
//        guard let imageData1 = UIImageJPEGRepresentation(UIImage(named: "meal1")!, 1.0) as NSData? else { return }
//        snap1.image = imageData1
//        snap1.latitude = 1.0
//        snap1.longitude = 1.0
//        snap1.address = "address 1"
//
//        let snap2 = SnapData(context: context)
//        guard let imageData2 = UIImageJPEGRepresentation(UIImage(named: "meal2")!, 1.0) as NSData? else { return }
//        snap2.image = imageData2
//        snap2.latitude = 2.0
//        snap2.longitude = 2.0
//        snap2.address = "address 2"

//        let task1 = Task(context: context)
//        task1.name = "name1"
//        let task2 = Task(context: context)
//        task2.name = "name2"

//        appDelegate.saveContext()
    }
}
