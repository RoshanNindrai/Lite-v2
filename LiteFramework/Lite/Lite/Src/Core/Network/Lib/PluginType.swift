//
//  PluginType.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public typealias ServiceResponse = (Data?, URLResponse?, Error?)

public protocol PluginType {

    /// This method is fired before making a resource request using the Webservice load method
    ///
    /// - Parameters:
    ///   - request: The actual Request for which a response is requested
    /// - Returns: A Request object that would be used to perform the Request request
    func willMakeRequest<Resource>(with request: Request<Resource>) -> Request<Resource>

    /// This method is fired after getting the network response but before calling the parse method within the Request
    ///
    /// - Parameters:
    ///   - response: The actual raw response from the dataTask on URLSession
    ///   - Request: The actual Request for which a response is requested
    /// - Returns: Returns an intercepted response object for Request parser to parse
    func willParseResponse<Resource>(response: ServiceResponse, for Request: Request<Resource>) -> ServiceResponse

}

extension PluginType {
    public func willMakeRequest<Resource>(with Request: Request<Resource>) -> Request<Resource> { return Request }
    public func willParseResponse<Resource>(response: ServiceResponse,
                                            for Request: Request<Resource>)
        -> ServiceResponse { return response }
}
