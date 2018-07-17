//
//  Request.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]

/// This struct is used to represent a resource
public struct Request<Resource> {
    let url: URL
    let method: HTTPMethod<Data>
    let parse: (Data) -> Resource?
}
