//
//  DisposeBag.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import Foundation

public final class Disposable {
    let dispose: HandlerVoid
    
    init(_ dispose: @escaping () -> Void) {
        self.dispose = dispose
    }
    
    deinit {
        dispose()
    }
}

public final class DisposeBag {
    private var disposables: [Disposable] = []
    public func append(_ disposable: Disposable) {
        disposables.append(disposable)
    }
}

public extension Disposable {
    func disposed(by bag: DisposeBag) {
        bag.append(self)
    }
}