//
//  DataOperation.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

/// For a given resource a data operation is created and fired off to network
public final class DataOperation<Resource: Codable>: NetworkOperation<Resource> {
    private var task: URLSessionDataTask?

    public override func main() {
        if isCancelled {
            state = .finished
        }
        task = session.dataTask(with: URLRequest(request)) { [unowned self] (data, response, error) in
            if let error = error {
                self.request.onFailureClosure?(error)
            } else if let data = data, let response = response {
                let parsedData = try? Coder.decoder.decode(Resource.self, from: data)
                self.request.onSuccessClosure?(parsedData, (data, response))
            }
            self.state = .finished
        }
        task?.resume()
    }
}
