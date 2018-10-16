//
//  Request.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]

/// This struct is used to represent a resource
public struct Request<Resource: Codable> {
    let url: URL
    let method: HTTPMethod
    let type: RequestType

    var header: Header?
    var parameters: [String: Any]?
    var body: Data?

    private(set) var plugins: [PluginType] = []

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

    /// Creates a request for a given provider
    ///
    /// - Parameter provider: A specific provider type for example httpbin, github
    init(_ provider: ProviderType) {
        self.init(url: provider.fullPathUrl,
                  method: provider.method,
                  type: provider.type,
                  header: provider.header,
                  parameters: provider.parameters, body: provider.body)
    }
}

// MARK: - Plugins related methods
extension Request {
    mutating func addPlugin(_ plugin: PluginType) {
        plugins.append(plugin)
    }

    mutating func addPlugins(_ plugins: [PluginType]) {
        self.plugins.append(contentsOf: plugins)
    }
}
