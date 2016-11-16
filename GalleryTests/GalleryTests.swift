//
//  GalleryTests.swift
//  GalleryTests
//
//  Created by Tom Sinlgeton on 14/10/2016.
//  Copyright © 2016 Tom Sinlgeton. All rights reserved.
//

import XCTest
@testable import Gallery

/// Test case for Gallerty
class GalleryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Gallery.setup()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /// Tests loading an image
    func testLoadImage() {
        let expect = expectation(description: "Image should download")
        
        let url = URL(string: "https://myanimelist.cdn-dena.com/images/anime/11/75274.jpg")!
        
        Gallery.getImage(for: url) { (result) in
            switch result {
            case let .success(image):
                break
            case let .failure(error):
                XCTFail("Error occured \(error)")
            }
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNil(error, "Test Timed Out \(error)")
        }
    }
    
}
