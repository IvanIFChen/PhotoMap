//
//  AlbumViewControllerTests.swift
//  PhotoMapTests
//
//  Created by Ivan Chen on 9/23/17.
//

import XCTest
@testable import PhotoMap

class AlbumViewControllerTest: XCTestCase
{
    var sut: AlbumViewController!

    override func setUp()
    {
        super.setUp()
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumViewControllerStoryBoardID")
            as? AlbumViewController
        _ = sut.view
    }

    override func tearDown()
    {
        super.tearDown()
    }
}

// MARK: - AlbumCardCell
extension AlbumViewControllerTest
{
    func testAlbumCardDataDidset()
    {

//
//        XCTAssertNil(cell.cardData)
//
//        let testImage = UIImage("testImage")
//        cell.cardData = ("test". testImage)
//
//        XCTAssertEqual(cell.cardLabel.text, "test")
//        XCTAssertEqual(cell.cardImage.image, testImage)

    }
}
