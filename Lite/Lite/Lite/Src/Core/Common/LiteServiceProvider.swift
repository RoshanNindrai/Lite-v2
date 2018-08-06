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

extension LiteServiceProvider: Provider {
    func perform(_ provider: Service, _ responseCallback: @escaping (Response<ResponseType>) -> Void) {
        let persistence = PersistedServiceProvider<Service, ResponseType>(configuration: configuration)
        persistence.perform(provider) { [unowned self] response in
            switch response {
            case .success(let data):
                responseCallback(.success(data))
            case .failure:
                self.network.perform(provider) { response in
                    switch response {
                    case .failure(let error):
                        responseCallback(.failure(error))
                    case .success(let data):
                        if let data = data {
                            let persistence = PersistedServiceProvider<Service, ResponseType>(configuration: self.configuration)
                            persistence.save(data)
                            responseCallback(.success(data))
                        } else {
                            responseCallback(.failure(PersistenceError.failedToPersistData))
                        }
                    }
                }
            }
        }
    }
}
