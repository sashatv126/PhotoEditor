//
//  ExtensionTests.swift
//  PhotoEditorTests
//
//  Created by Александр Александрович on 12.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import XCTest
import UIKit.UIView
@testable import PhotoEditor

final class PetProjectExtensionTests: XCTestCase {
    
    var text: String!
    var collection: Array<String>!
    var matchString: String!
    var randomCollection: Array<Int>!
    var safeIndexInCollection: Array<Int>!
    var view: UIView!
    
    func testStrNilOrEmpty() {
        text = ""
        let exp = text.isNilOrEmpty
        XCTAssertEqual(exp, true)
    }
    
    func testCollectionIsNilOrEmpty() {
        collection = ["1"]
        
        let exp = collection.isNilOrEmpty
        XCTAssertEqual(exp, false)
    }
    
    func testMatchOptional() {
        matchString = "123"
        
        let exp = matchString
            .matching { Int($0) == nil }
            .matching { $0.count > 2 }
        
        XCTAssertNil(exp)
    }
    
    func testElementInRandomCollection() {
        randomCollection = [1,2,3]
        
        let exp = randomCollection.element(at: 2)
        
        XCTAssertEqual(exp, 3)
    }
    
    func testSafeIndexInCollection() {
        safeIndexInCollection = [1,2,3]
        
        let exp = safeIndexInCollection[safe: 4]
        
        XCTAssertNil(exp)
    }
    
    func testGetView() {
        view = UIView()
        
        let exp = view.get(orSet: UIView())
        
        XCTAssertEqual(exp, view)
    }
    
    func testAddSubviews() {
        view = UIView()
        let sub = UIView()
        
        view.addSubviews(sub)
        XCTAssertEqual(view.subviews.count, 1)
    }

}
