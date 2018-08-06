//
//  PipelineProtocol.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public protocol PipeLine {
    associatedtype Resource: Codable

    var getter: (Request<Resource>) -> ResponseCallback<Resource> { get set }
    var setter: (Request<Resource>, Resource) -> Void { get set }

    init(getter: (Request<Resource>) -> ResponseCallback<Resource>,
         setter: (Request<Resource>, Resource) -> Void)

}
