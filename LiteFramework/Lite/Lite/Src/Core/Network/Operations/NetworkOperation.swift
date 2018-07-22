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
    private(set) var request: Request<Resource>
    let responseCallback: ResponseCallback<Resource>

    init(_ session: URLSession, _ request: Request<Resource>, _ responseCallback: ResponseCallback<Resource>) {
        self.session = session
        self.request = request
        self.responseCallback = responseCallback
    }

    public override func main() {

        if isCancelled {
            state = .finished
            return
        }

        let plugins = request.plugins
        request = plugins.reduce(request, { (request, plugin) in
            return plugin.willMakeRequest(with: request)
        })

    }

}
