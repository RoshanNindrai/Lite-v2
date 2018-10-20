//
//  Cacheable.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

open class RealmEntity: Object {
    required init() {
        super.init()
    }

    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required public init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}
