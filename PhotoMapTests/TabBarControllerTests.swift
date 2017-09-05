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
        sut = UITabBarController()
        _ = sut.view
//        sut.viewControllers?.forEach
//        { (viewController) in
//            _ = viewController.view
//        }
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testTabBarItemTypeTitle()
    {
        XCTAssertTrue(TabBarController.TabBarItemType.map.tabBarTitle() == "Map")
        XCTAssertTrue(TabBarController.TabBarItemType.camera.tabBarTitle() == "Camera")
        XCTAssertTrue(TabBarController.TabBarItemType.album.tabBarTitle() == "Album")
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
}
