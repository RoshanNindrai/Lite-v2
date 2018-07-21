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
    func willMakeRequest<P>(with request: Request<P>) -> Request<P>

    /// This method is fired after making a Request request
    ///
    /// - Parameters:
    ///   - Request: The actual Request for which a response is requested
    ///   - urlRequest: The actual URLRequest that was made to the server
    func didMakeRequest<P>(with request: Request<P>, urlRequest: URLRequest)

    /// This method is fired after getting the network response but before calling the parse method within the Request
    ///
    /// - Parameters:
    ///   - response: The actual raw response from the dataTask on URLSession
    ///   - Request: The actual Request for which a response is requested
    /// - Returns: Returns an intercepted response object for Request parser to parse
    func willParseResponse<P>(response: ServiceResponse, for Request: Request<P>) -> ServiceResponse

}

extension PluginType {
    public func willMakeRequest<P>(with Request: Request<P>) -> Request<P> { return Request }
    public func didMakeRequest<P>(with Request: Request<P>, request: URLRequest) {}
    public func willParseResponse<P>(response: ServiceResponse,
                                     for Request: Request<P>) -> ServiceResponse { return response }
}
