//
//  Service.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

final public class Service: NSObject {

    //contains all the plugins that is needed during load method
    fileprivate var plugins: [PluginType] = []

    //  The configuration for the session that is to be handled
    fileprivate var sessionConfig: URLSessionConfiguration = .default {
        didSet { Service.shared.sessionConfig = sessionConfig }
    }
    //  The actual session object
    fileprivate var session: URLSession
    //  shared object for performing all WebService calls
    static let shared: Service = Service()

    override init() {
        session = URLSession.init(configuration: sessionConfig)
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

    /// This method add a colelction of plugins type to the webservice
    ///
    /// - Parameter plugins: The actual plugin that needs to be added as part of the service
    class func add(plugins: [PluginType]) {
        shared.plugins.append(contentsOf: plugins)
    }
}
