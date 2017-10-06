//
//  Snap.swift
//  PhotoMap
//
//  Created by Ivan Chen on 9/25/17.
//

import Foundation
import UIKit
import CoreLocation

class Snap
{
    let image: UIImage
    let latitude: Double
    let longitude: Double
    var address: String?
//    var formattedAddressLines: [String]

//    init(image: UIImage, latitude: Double, longitude: Double, formattedAddressLines: [String])
    init(image: UIImage, latitude: Double, longitude: Double, address: String)
    {
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
//        self.formattedAddressLines = formattedAddressLines
        self.address = address
    }

    static func == (lhs: Snap, rhs: Snap) -> Bool
    {
        return UIImagePNGRepresentation(lhs.image) == UIImagePNGRepresentation(rhs.image) &&
                lhs.latitude == rhs.latitude &&
                lhs.longitude == rhs.longitude &&
//                lhs.formattedAddressLines == rhs.formattedAddressLines
                lhs.address == rhs.address
    }

}
