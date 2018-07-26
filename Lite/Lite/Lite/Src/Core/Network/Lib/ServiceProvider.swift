//
//  ServiceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/25/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public protocol Provider {
    associatedtype ServiceProviderType: ProviderType
    func perform<Resource: Codable>(_ provider: ServiceProviderType, _ responseCallback: ResponseCallback<Resource>)
}

// MARK: - Task executions
public extension Provider {
    func perform<Resource: Codable>(_ provider: ServiceProviderType, _ responseCallback: ResponseCallback<Resource>) {
        Service.perform(provider, responseCallback)
    }
}

public struct ServiceProvider<ServiceProviderType: ProviderType>: Provider {}
