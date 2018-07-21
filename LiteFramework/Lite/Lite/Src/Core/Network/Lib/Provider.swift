//
//  Provider.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public protocol ProviderType {

    var baseURL: String { get }
    var path: String? { get }

    var method: HTTPMethod { get }
    var type: RequestType { get }

    var header: Header? { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
}

extension ProviderType {

    var fullPathUrl: URL {
        return URL(string: baseURL + (path ?? ""))!
    }
}
