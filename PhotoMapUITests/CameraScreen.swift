//
//  CameraScreen.swift
//  PhotoMap
//
//  Created by Ivan Chen on 9/4/17.
//
//

import XCTest

struct CameraScreen
{
    // let foo: XCUIElement
    let title: XCUIElement

    init(app: XCUIApplication)
    {
        // foo = app.staticTexts.element(matching: .staticText/.button, identifier: "foo")
        title = app.staticTexts.element(matching: .staticText, identifier: "Camera")
    }
}
