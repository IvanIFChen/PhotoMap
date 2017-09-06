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

    override func tearDown()
    {
        super.tearDown()
    }

    func testTapOnCameraTabShowsCameraTab()
    {
        app.launch()

        app.cameraTab.tap()

        // TODO check it's the camera view
    }
}

extension XCUIApplication
{
    var cameraTab: XCUIElement
    {
        return buttons.element(matching: .button, identifier: "Camera")
    }
}
