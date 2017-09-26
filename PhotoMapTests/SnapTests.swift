//
//  SnapTests.swift
//  PhotoMapTests
//
//  Created by Ivan Chen on 9/25/17.
//

import XCTest
import CoreLocation
@testable import PhotoMap

class SnapTests: XCTestCase
{
    var sut: Snap!

    override func setUp()
    {
        super.setUp()
        sut = Snap()
    }

    override func tearDown()
    {
        sut = nil
        super.tearDown()
    }

    func testSnapEquatable()
    {
        XCTAssertEqual(sut, Snap(image: UIImage(), location: CLLocation()))
    }
}
