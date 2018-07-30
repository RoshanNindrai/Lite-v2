//
//  ServiceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/25/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public protocol Provider {

    var service: Service { get }

    associatedtype ServiceProviderType: ProviderType
    associatedtype ResponseType: Codable
    func perform(_ provider: ServiceProviderType,
                 _ responseCallback: @escaping (Response<ResponseType>) -> Void)
}

// MARK: - Task executions
public extension Provider {
    func perform(_ provider: ServiceProviderType,
                 _ responseCallback: @escaping (Response<ResponseType>) -> Void) {
        service.perform(provider, ResponseCallback<ResponseType>(handler: responseCallback))
    }
}

public struct ServiceProvider<ServiceProviderType: ProviderType, ResponseType: Codable>: Provider {
    public var service: Service

    public init(service: Service = Service.shared) {
        self.service = service
    }
}
