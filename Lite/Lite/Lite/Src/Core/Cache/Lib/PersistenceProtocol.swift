//
//  Service.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public enum PersistenceError: Error {
    case failedInitializingRealm
    case noDataFound
    case predicateNotFound
    case failedToPersistData
}

public protocol TranslatorProtocol {
    associatedtype PersistedResource: NSObject
    static func translate(_ data: PersistedResource) -> Self?
    static func reverseTranslate(_ data: Self) -> PersistedResource?
}

public protocol PersistenceProtocol {
    func fetch<Resource>(_ predicate: NSPredicate,
                         _ handler: ResponseCallback<Resource>)
        where Resource: TranslatorProtocol

    func save<Resource>(_ data: Resource, _ handler: VoidSaveBlock?)
        where Resource: TranslatorProtocol
}
