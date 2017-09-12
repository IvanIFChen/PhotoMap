//
//  TabBarControllerTests.swift
//  PhotoMap
//
//  Created by Ivan Chen on 8/27/17.
//
//

import XCTest
@testable import PhotoMap

class TabBarControllerTests: XCTestCase
{
    var sut: UITabBarController!

    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarControllerStoryBoardID") as? UITabBarController
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTabBarControllerTitles()
    {
        guard let tabs = sut.tabBar.items else
        {
            XCTFail("tab bar is nil")
            return
        }
        XCTAssertTrue(tabs[0].title == "Map")
        XCTAssertTrue(tabs[1].title == "Camera")
        XCTAssertTrue(tabs[2].title == "Album")
    }

    func testCorrectChildViewControllers()
    {
        XCTAssertTrue(sut.childViewControllers[0] is MapViewController)
        XCTAssertTrue(sut.childViewControllers[1] is CameraViewController)
        XCTAssertTrue(sut.childViewControllers[2] is AlbumViewController)
    }
}
