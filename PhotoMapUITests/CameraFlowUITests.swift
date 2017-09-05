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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTapOnCameraTabShowsCameraTab()
    {
        app.launch()

        app.cameraTab.tap()

        // TODO check it's at the camera view
    }

}

extension XCUIApplication
{
    var cameraTab: XCUIElement
    {
        return buttons.element(matching: .button, identifier: "Camera")
    }
}
