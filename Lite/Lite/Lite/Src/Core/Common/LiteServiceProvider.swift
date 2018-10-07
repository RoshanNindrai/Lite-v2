//
//  LiteServiceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/5/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import Realm

final class LiteServiceProvider<Service: ProviderType & PersistenceProviderType,
                                ResponseType: Codable & TranslatorProtocol> {

    let network: NetworkServiceProvider<Service, ResponseType>
    let configuration: RLMRealmConfiguration

    public init(_ network: NetworkServiceProvider<Service, ResponseType> = NetworkServiceProvider(),
                _ configuration: RLMRealmConfiguration) {
        self.network = network
        self.configuration = configuration
    }

}

extension LiteServiceProvider {
    func perform(_ provider: Service, _ responseCallback: @escaping (Response<ResponseType>) -> Void) {
        let persistence = PersistedServiceProvider<Service, ResponseType>(configuration: configuration)
        let composedServiceProvider = persistence |& network
        composedServiceProvider.execute(provider, responseCallback)
    }
}
