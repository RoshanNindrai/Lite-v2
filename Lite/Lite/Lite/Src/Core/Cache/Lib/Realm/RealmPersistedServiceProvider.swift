//
//  PersistedServiceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import Realm

private protocol PersistedServiceProviderProtocol: PipeLine {

    var persistence: PersistenceProtocol { get }

    func save(_ data: Resource, _ handler: VoidSaveBlock?)
}

public struct PersistedServiceProvider<ServiceProviderType: ProviderType & PersistenceProviderType,
Resource: Codable & TranslatorProtocol>: PersistedServiceProviderProtocol {

    fileprivate let persistence: PersistenceProtocol
    public var getter: ((ServiceProviderType, ResponseCallback<Resource>) -> Void)?

    public init(configuration: RLMRealmConfiguration = RLMRealmConfiguration.default()) {
        self.persistence = RealmService(configuration)

    }

    public init(getter: @escaping (ServiceProviderType, ResponseCallback<Resource>) -> Void) {
        persistence = RealmService(RLMRealmConfiguration.default())
        self.getter = getter
    }
}

extension PersistedServiceProvider {

    public func perform(_ provider: ServiceProviderType,
                        _ responseCallback: @escaping (Response<Resource>) -> Void) {
        persistence.fetch(provider.predicate, ResponseCallback<Resource> { response in
            switch response {
            case .success(let resource):
                responseCallback(.success(resource))
            case .failure(let error):
                responseCallback(.failure(error))
            }
        })
    }

    public func save(_ data: Resource, _ handler: VoidSaveBlock? = nil) {
        persistence.save(data, handler)
    }

}
