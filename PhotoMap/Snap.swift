//
//  Snap.swift
//  PhotoMap
//
//  Created by Ivan Chen on 9/25/17.
//

import Foundation
import UIKit
import CoreLocation

struct Snap: Equatable
{
    var image: UIImage
    var location: CLLocation

    init()
    {
        self.image = UIImage()
        self.location = CLLocation()
    }

    init(image: UIImage, location: CLLocation)
    {
        self.image = image
        self.location = location
    }

    static func == (lhs: Snap, rhs: Snap) -> Bool
    {
        return UIImagePNGRepresentation(lhs.image) == UIImagePNGRepresentation(rhs.image) &&
            lhs.location.coordinate.latitude == rhs.location.coordinate.latitude &&
            lhs.location.coordinate.longitude == rhs.location.coordinate.longitude
    }

}
