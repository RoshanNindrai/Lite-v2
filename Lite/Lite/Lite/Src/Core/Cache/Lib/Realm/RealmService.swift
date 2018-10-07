//
//  RealmService.swift
//  Lite
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public final class RealmService {

    private var service: Realm?
    private var configuration: RLMRealmConfiguration

    public init(_ realmConfig: RLMRealmConfiguration = RLMRealmConfiguration.default()) {
        self.configuration = realmConfig
        RLMRealmConfiguration.setDefault(self.configuration)
        self.service = try? Realm()
    }
}

extension RealmService: PersistenceProtocol {
    public func fetch<PersistedResource, Resource>(_ predicate: NSPredicate,
                                                   _ handler: ResponseCallback<Resource>)
        where PersistedResource == Resource.PersistedResource, Resource: TranslatorProtocol {
            if let realm = service {
                let persistedData = realm.objects(PersistedResource.self).filter(predicate)
                guard let resource = persistedData.first else {
                    handler.handle(.failure(PersistenceError.noDataFound))
                    return
                }
                handler.handle(.success(Resource.translate(resource)))
                return
            }
            handler.handle(.failure(PersistenceError.failedInitializingRealm))
    }

    public func save<PersistedResource, Resource>(_ data: Resource, _ handler: VoidSaveBlock? = nil)
        where PersistedResource == Resource.PersistedResource, Resource: TranslatorProtocol {
        do {
            service = try Realm()
            try service?.write {
                if let realmData = Resource.reverseTranslate(data) {
                    service?.add(realmData)
                }
            }
            handler?()
        } catch {
            print(error)
            handler?()
        }
    }
}
