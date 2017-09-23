//
//  CameraFlowUITests.swift
//  PhotoMap
//
//  Created by Ivan Chen on 9/4/17.
//
//

import XCTest

class CameraFlowUITests: XCTestCase
{
    let app = XCUIApplication()
    var cameraScreen: CameraScreen!

    override func setUp()
    {
        super.setUp()
        cameraScreen = CameraScreen(app: app)
    }

    func testTapOnCameraTabShowsCameraTab()
    {
        let app = XCUIApplication()
        let cameraButton = app.tabBars.buttons["Camera"]
        cameraButton.tap()
//
        // swiftlint:disable line_length
        let element3 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let element = element3.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.tap()
        // swiftlint:enable line_length
        // question: how do I UI test this? Or even unit test this? (the image picker)
        
        // TODO check it's the camera view
    }
}
