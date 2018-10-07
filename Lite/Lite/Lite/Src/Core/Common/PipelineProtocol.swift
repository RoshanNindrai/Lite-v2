//
//  PipelineProtocol.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

precedencegroup ComposePredecesor {
    associativity: left
}

infix operator |&: ComposePredecesor

func |&<A: PipeLine, B: PipeLine>(_ left: A, _ right: B) -> A where A.Resource == B.Resource,
    A.ServiceProviderType == B.ServiceProviderType {
    return left.compose(right)
}

public protocol PipeLine: Provider {
    var getter: ((ServiceProviderType, ResponseCallback<Resource>) -> Void)? { get set  }

    init(getter: @escaping (ServiceProviderType, ResponseCallback<Resource>) -> Void)

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
