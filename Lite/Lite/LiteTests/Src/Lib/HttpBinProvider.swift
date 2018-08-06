//
//  HttpBinProvider.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
@testable import Lite

struct HTTPBinPost: Codable {
    let data = "me"
}

enum HttpBin: ProviderType {
    case get
    case post(HTTPBinPost)
}

extension HttpBin {

    var baseURL: String {
        return "https://httpbin.org"
    }

    var path: String? {
        switch self {
        case .get:
            return "/get"
        case .post:
            return "/post"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }

    var type: RequestType {
        return .data
    }

    var header: Header? {
        return nil
    }

    var parameters: [String: Any]? {
        return nil
    }

    var body: Data? {
        if case let .post(data) = self {
            return try? Coder.encoder.encode(data)
        }
        return nil
    }
}

extension HttpBin: PersistenceProviderType {
    var predicate: NSPredicate {
        return NSPredicate(format: "url == %@", "https://httpbin.org/get")
    }
}
