//
//  Future.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public class Future<T> {

    var callbacks: [(T) -> Void] = []
    var cached: T?

    init(_ compute: (@escaping (T) -> Void) -> Void) {
        compute(send)
    }

    private func send(_ result: T) {
        assert(cached == nil)
        cached = result
        callbacks.forEach { callback in
            callback(cached!)
        }
        callbacks = []
    }

    @discardableResult
    public func onResult(_ callback:(@escaping (T) -> Void)) -> Future<T> {
        if let result = cached {
            callback(result)
        } else {
            callbacks.append(callback)
        }
        return self
    }

    @discardableResult
    public func flatMap<B>(_ transform: @escaping (T) -> Future<B>) -> Future<B> {
        return Future<B> { completion in
            onResult { result in
                transform(result).onResult(completion)
            }
        }
    }

}
