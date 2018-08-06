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
    associatedtype ResponseType: Codable
    func perform(_ provider: ServiceProviderType,
                 _ responseCallback: @escaping (Response<ResponseType>) -> Void)
}

public protocol NetworkProviderProtocol: Provider {
    var service: Service { get }
}

public struct NetworkServiceProvider<ServiceProviderType: ProviderType, ResponseType: Codable>: Provider {
    public var service: Service

    public init(service: Service = Service.shared) {
        self.service = service
    }
}

extension NetworkServiceProvider {
    public func perform(_ provider: ServiceProviderType,
                        _ responseCallback: @escaping (Response<ResponseType>) -> Void) {
        service.perform(provider, ResponseCallback<ResponseType>(handler: responseCallback))
    }
}
