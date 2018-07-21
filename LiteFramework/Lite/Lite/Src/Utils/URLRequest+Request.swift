//
//  URLRequest+Request.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public extension URLRequest {
    init<Resource>(_ request: Request<Resource>) {
        self.init(url: request.url)
        httpMethod = request.method.methodString
        allHTTPHeaderFields = request.header
        httpBody = request.method.data
    }
}
