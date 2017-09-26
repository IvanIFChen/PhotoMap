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
    let image: UIImage
    let location: CLLocation

    static func ==(lhs: Snap, rhs: Snap) -> Bool
    {
        return lhs.image == rhs.image &&
            lhs.location == rhs.location
    }

    init(image: UIImage, location: CLLocation)
    {
        self.image = image
        self.location = location
    }
}
