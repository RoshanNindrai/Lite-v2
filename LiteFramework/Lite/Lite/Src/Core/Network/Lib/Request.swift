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
    var body: Data?

    init(url: URL, method: HTTPMethod,
         type: RequestType,
         header: Header? = nil,
         parameters: [String: Any]? = nil,
         body: Data? = nil) {

        self.type = type
        self.url = url
        self.method = method
        self.header = header
        self.parameters = parameters
        self.body = body
    }
}

extension Request {

    convenience init(_ provider: ProviderType) {
        self.init(url: provider.fullPathUrl,
                  method: provider.method,
                  type: provider.type,
                  header: provider.header,
                  parameters: provider.parameters, body: provider.body)
    }

}
