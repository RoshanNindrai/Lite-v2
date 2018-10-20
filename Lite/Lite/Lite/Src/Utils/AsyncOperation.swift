//
//  AsyncOperation.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public class AsyncOperation: Operation {

    public enum State: String {
        case ready, executing, finished
        
        var keyPath: String {
            return isPrefixed()
        }
        
        private func isPrefixed() -> String {
            return "is" + rawValue.capitalized
        }
    }

    
    override public var isAsynchronous: Bool { return true }

    public var state: State = .ready {
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
    }

    override public var isExecuting: Bool {
        return state == .executing
    }

    override public var isFinished: Bool {
        return state == .finished
    }

    override public func start() {
        if isCancelled {
            state = .finished
        } else {
            state = .executing
            main()
        }
    }

    override public func main() {
        if isCancelled {
            state = .finished
        }
        state = .finished
    }

}
