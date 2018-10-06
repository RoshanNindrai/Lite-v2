//
//  Service.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import RealmSwift

public typealias VoidSaveBlock = () -> Void

public enum PersistenceError: Error {
    case failedInitializingRealm
    case noDataFound
    case failedToPersistData
}

public protocol TranslatorProtocol {
    associatedtype PersistedResource: Object
    static func translate(_ data: PersistedResource) -> Self?
    static func reverseTranslate(_ data: Self) -> PersistedResource?
}

public protocol PersistenceProtocol {
    func fetch<PersistedResource, Resource: TranslatorProtocol>(_ predicate: NSPredicate,
                                                                _ handler: ResponseCallback<Resource>)
        where Resource.PersistedResource == PersistedResource

    func save<PersistedResource, Resource>(_ data: Resource, _ handler: VoidSaveBlock?)
        where PersistedResource == Resource.PersistedResource, Resource: TranslatorProtocol

}
