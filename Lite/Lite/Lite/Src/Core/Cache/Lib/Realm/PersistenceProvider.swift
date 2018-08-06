//
//  PersistenceProvider.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import RealmSwift

public protocol PersistenceProviderType {
    var predicate: NSPredicate { get }
}
