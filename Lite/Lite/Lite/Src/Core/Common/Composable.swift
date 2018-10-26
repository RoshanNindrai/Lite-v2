//
//  Composable.swift
//  Lite
//
//  Created by Roshan Nindrai on 10/7/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

precedencegroup ComposePredecesor {
    associativity: left
}

infix operator |&: ComposePredecesor

public func |&<A: PipeLine, B: PipeLine>(_ left: A, _ right: B) -> A where A.Resource == B.Resource,
    A.ServiceProviderType == B.ServiceProviderType {
        return left.compose(right)
}
