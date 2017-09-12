//
//  UITestHelper.swift
//  PhotoMap
//
//  Created by Ivan Chen on 9/4/17.
//
//

import XCTest

class App: XCUIApplication
{
    // might not need this
}

// MARK: Map Stuff
extension XCUIApplication
{
    var mapTab: XCUIElement
    {
        return buttons.element(matching: .button, identifier: "Map")
    }
}

// MARK: Camera Stuff
extension XCUIApplication
{
    var cameraTab: XCUIElement
    {
        return buttons.element(matching: .button, identifier: "Camera")
    }
}

// MARK: Album Stuff
extension XCUIApplication
{
    var albumTab: XCUIElement
    {
        return buttons.element(matching: .button, identifier: "Album")
    }
}
