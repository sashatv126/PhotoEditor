//
//  Observable.swift
//  PhotoEditor
//
//  Created by Александр Александрович on 16.02.2023.
//  Copyright © 2023 tuist.io. All rights reserved.
//

import UIKit

public final class Observable<Value> {
    private var listeners: [UUID: Listener] = [:]
    
    public typealias Listener = (Value) -> Void
    
    public var value: Value {
        didSet {
            listeners.values.forEach { $0(value) }
        }
    }

    public init(_ value: Value){
        self.value = value
    }

    public func bindAndFire(_ listener: @escaping Listener) -> Disposable {
        let identifier = UUID()
        self.listeners[identifier] = listener
        listener(value)
        return Disposable { self.listeners.removeValue(forKey: identifier) }
    }
}

