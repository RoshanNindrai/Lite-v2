//
//  Service.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public final class Service: NSObject {

    //contains all the plugins that is needed during load method
    private var plugins: [PluginType] = []

    /// Operation queue in which all the network operations are performed
    private let queue: OperationQueue

    //  The configuration for the session that is to be handled
    private var sessionConfig: URLSessionConfiguration = .default {
        didSet { Service.shared.sessionConfig = sessionConfig }
    }
    //  The actual session object
    private var session: URLSession
    //  shared object for performing all WebService calls
    static let shared: Service = Service()

    override init() {
        session = URLSession.init(configuration: sessionConfig)
        queue = OperationQueue()
    }
}

public extension Service {

    /// To add custom session configuration to the URLSession
    ///
    /// - parameter config: configuration for the session configuration
    func sessionConfiguration(config: URLSessionConfiguration) {
        sessionConfig = config
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
    }

}

// MARK: Plugin support
public extension Service {

    /// This method add a collection of plugins type to the webservice
    ///
    /// - Parameter plugins: The actual plugin that needs to be added as part of the service
    class func add(plugins: [PluginType]) {
        shared.plugins.append(contentsOf: plugins)
    }
}

// MARK: - Task executions
public extension Service {

    private func perform<Resource>(_ request: Request<Resource>) {
        switch request.type {
        case .data:
            let operation = DataOperation(session, request)
            queue.addOperation(operation)
        }
    }

    static func perform<Resource>(_ request: Request<Resource>) {
        shared.perform(request)
    }

}
