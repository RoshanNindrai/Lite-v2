//
//  Request.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]
public typealias Header = [String: String]

/// This struct is used to represent a resource
public final class Request<Resource: Codable> {
    let url: URL
    let method: HTTPMethod
    let type: RequestType

    var header: Header?
    var parameters: [String: Any]?
    var body: Codable?

    private(set) var onSuccessClosure: ((Resource?, (Data, URLResponse)) -> Void)?
    private(set) var onFailureClosure: ((Error) -> Void)?

    init(url: URL, method: HTTPMethod,
         type: RequestType,
         header: Header? = nil,
         parameters: [String: Any]? = nil,
         body: Codable? = nil) {

        self.type = type
        self.url = url
        self.method = method
        self.header = header
        self.parameters = parameters
        self.body = body
    }
}

// MARK: - Conformance to Network Operation
extension Request {
    /// This method is Called when the network operation completes and it has a success response
    ///
    /// - Parameter handler: A function that is provided with the actual network data and response
    /// - Returns: THe current operation
    @discardableResult
    public func onSuccess(_ handler: @escaping (Resource?, (Data, URLResponse)) -> Void) -> Request<Resource> {
        onSuccessClosure = handler
        return self
    }

    /// This method is Called when the network operation completes with a failure
    ///
    /// - Parameter handler: A function that is provided with the actual error data
    /// - Returns: THe current operation
    @discardableResult
    public func onFailure(_ handler: @escaping (Error) -> Void) -> Request<Resource> {
        onFailureClosure = handler
        return self
    }
}
