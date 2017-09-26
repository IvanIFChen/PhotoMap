//
//  Snap.swift
//  PhotoMap
//
//  Created by Ivan Chen on 9/25/17.
//

import Foundation
import UIKit
import CoreLocation

class Snap: NSObject, NSCoding
{
    var image: UIImage
    var location: CLLocation
    var placemark: CLPlacemark?

    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("snaps")

    override init()
    {
        self.image = UIImage()
        self.location = CLLocation()
    }

    init(image: UIImage, location: CLLocation, placemark: CLPlacemark?)
    {
        self.image = image
        self.location = location
        self.placemark = placemark

        // NOTE: is it possible to reverse geocode in init? do it in another thread or something
//        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
//        { (placemarks, _) in
//            if let placemark = placemarks?.first
//            {
//               slef.placemark = placemark
//            }
//        })
    }

    static func == (lhs: Snap, rhs: Snap) -> Bool
    {
        return UIImagePNGRepresentation(lhs.image) == UIImagePNGRepresentation(rhs.image) &&
                lhs.location.coordinate.latitude == rhs.location.coordinate.latitude &&
                lhs.location.coordinate.longitude == rhs.location.coordinate.longitude
    }

    // MARK: - NSCoding

    struct PropertyKey
    {
        static let image = "image"
        static let location = "location"
        static let placemark = "placemark"
    }

    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(placemark, forKey: PropertyKey.placemark)
    }

    required convenience init?(coder aDecoder: NSCoder)
    {
        guard let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage else {
            print("Unable to decode the image for a Snap object.")
            return nil
        }
        guard let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? CLLocation else {
            print("Unable to decode the location for a Snap object.")
            return nil
        }

        let placemark = aDecoder.decodeObject(forKey: PropertyKey.placemark) as? CLPlacemark

        self.init(image: image, location: location, placemark: placemark)
    }

}
