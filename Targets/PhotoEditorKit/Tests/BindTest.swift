//
//  BindTest.swift
//  PhotoEditorTests
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import XCTest
import PhotoEditor

final class BindTest: XCTestCase {
    
    var value: Observable<String>?

    func testBind() {
        let disposeBag = DisposeBag()
        value = Observable("a")
        
        value?.bindAndFire({ str in
            XCTAssertEqual(str, "a")
        }).disposed(by: disposeBag)
    }
}
