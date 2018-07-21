//
//  NetworkOperation.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

/// All network operation types should conform to this protocol
/// Refer DataOperation for concrete implementation
public class NetworkOperation<Resource: Codable>: AsyncOperation {
    let session: URLSession
    let request: Request<Resource>

    init(_ session: URLSession, _ request: Request<Resource>) {
        self.session = session
        self.request = request
    }
}
