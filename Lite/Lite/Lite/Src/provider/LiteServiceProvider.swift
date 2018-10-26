//
//  LiteServiceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/5/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import PromiseKit
import Realm

public typealias LiteResponseType = Codable & TranslatorProtocol
public final class LiteServiceProvider<Service: ProviderType & PersistenceProviderType,
                                       ResponseType: LiteResponseType> {

    let network: NetworkServiceProvider<Service, ResponseType>
    let configuration: RLMRealmConfiguration

    public init(_ network: NetworkServiceProvider<Service, ResponseType> = NetworkServiceProvider(),
                _ configuration: RLMRealmConfiguration) {
        self.network = network
        self.configuration = configuration
    }

    convenience public init() {
        self.init(NetworkServiceProvider(), RLMRealmConfiguration.default())
    }

}

public extension LiteServiceProvider {

    func perform(_ provider: Service, _ responseCallback: @escaping (Response<ResponseType>) -> Void) {
        let persistence = PersistedServiceProvider<Service, ResponseType>(configuration: configuration)
        let composedServiceProvider = persistence |& network
        composedServiceProvider.execute(provider, responseCallback)
    }

    func perform(_ provider: Service) -> Promise<ResponseType?> {
        return Promise<ResponseType?> { seal in
            perform(provider) { response in
                switch response {
                case .success(let data):
                    seal.fulfill(data)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}
