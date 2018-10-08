//
//  Provider.swift
//  Lite
//
//  Created by Roshan Nindrai on 10/7/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public protocol Provider {
    associatedtype ServiceProviderType: ProviderType
    associatedtype Resource: Codable
}
