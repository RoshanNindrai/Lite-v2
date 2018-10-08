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
    public func fetch<Resource>(_ predicate: NSPredicate, _ handler: ResponseCallback<Resource>)
        where Resource: TranslatorProtocol {
            if let realm = service, let RealmResourceType = Resource.PersistedResource.self as? Object.Type {
                let persistedData = realm.objects(RealmResourceType).filter(predicate)
                guard let resource = persistedData.first as? Resource.PersistedResource else {
                    handler.handle(.failure(PersistenceError.noDataFound))
                    return
                }
                handler.handle(Response.success(Resource.translate(resource)))
                return
            }
            handler.handle(.failure(PersistenceError.failedInitializingRealm))
    }

    public func save<PersistedResource, Resource>(_ data: Resource, _ handler: VoidSaveBlock? = nil)
        where PersistedResource == Resource.PersistedResource, Resource: TranslatorProtocol {
        do {
            service = try Realm()
            try service?.write {
                if let realmData = Resource.reverseTranslate(data) as? Object {
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
