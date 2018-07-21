//
//  HTTPMethod.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

/// This represent the kind of network activity that is gonna takes place
///
/// - POST:   used for a post request
/// - GET:    used for a get request
/// - DELETE: used for a delete request
/// - PUT:    used for a put request
public enum HTTPMethod {
    case get
    case post([String: String])
    case delete([String: String])
    case put([String: String])
}

struct Coder {
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
}

extension HTTPMethod {
    /// Return the http method as string
    var methodString: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        case .put: return "PUT"
        }
    }

    /// Data used to send via wire
    var data: Data? {
        switch self {
        case .get:
            return nil
        case let .post(body):
            return try? Coder.encoder.encode(body)
        case let .delete(data):
            return try? Coder.encoder.encode(data)
        case let .put(data):
            return try? Coder.encoder.encode(data)

        }
    }
}
