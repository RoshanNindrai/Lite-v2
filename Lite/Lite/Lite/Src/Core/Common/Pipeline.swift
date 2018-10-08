//
//  PipelineProtocol.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public protocol PipeLine: Provider {

    /// Variables
    var getter: ((ServiceProviderType, ResponseCallback<Resource>) -> Void)? { get set  }

    /// Initializes a pipeline with getter that is being used for composing
    ///
    /// - Parameter getter: The getter that gets called as part of fallback
    init(getter: @escaping (ServiceProviderType, ResponseCallback<Resource>) -> Void)

    /// This method is called within the getter to perform fetching of provider requested data
    ///
    /// - Parameters:
    ///   - provider: The provider for which the perform fetch is performed
    ///   - responseCallback: The method that gets fired when the perform action is completed in async way.
    func perform(_ provider: ServiceProviderType,
                 _ responseCallback: @escaping (Response<Resource>) -> Void)
    func save(_ data: Resource, _ handler: VoidSaveBlock?)
}

extension PipeLine {
    public func save(_ data: Resource, _ handler: VoidSaveBlock?) {
        // Save might not be required to be implemented for example network layer
    }
}

extension PipeLine {
    func compose<Pipe: PipeLine>(_ second: Pipe) -> Self where Pipe.Resource == Self.Resource,
        Pipe.ServiceProviderType == Self.ServiceProviderType {
            return Self.init(getter: { provider, callback in
                self.perform(provider) { response in
                    switch response {
                    case .failure:
                        second.perform(provider) { response in
                            switch response {
                            case .success(let resource):
                                guard let resource = resource else {
                                    callback.handle(response)
                                    return
                                }
                                self.save(resource, nil)
                                callback.handle(response)
                            default:
                                callback.handle(response)
                            }
                        }
                    case .success:
                        callback.handle(response)
                    }
                }
            })
    }

    func execute(_ provider: ServiceProviderType,
                 _ responseCallback: @escaping (Response<Resource>) -> Void) {
        getter?(provider, ResponseCallback(handler: responseCallback))
    }
}
