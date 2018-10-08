//
//  ServiceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/25/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public struct NetworkServiceProvider<ServiceProviderType: ProviderType, Resource: Codable>: PipeLine {

    private let service: Service
    public var getter: ((ServiceProviderType, ResponseCallback<Resource>) -> Void)?

    public init(service: Service = Service.shared) {
        self.service = service
    }

    public init(getter: @escaping (ServiceProviderType, ResponseCallback<Resource>) -> Void) {
        self.service = Service.shared
        self.getter = getter
    }
}

extension NetworkServiceProvider {
    public func perform(_ provider: ServiceProviderType,
                        _ responseCallback: @escaping (Response<Resource>) -> Void) {
        service.perform(provider, ResponseCallback<Resource>(handler: responseCallback))
    }
}
