//
//  ResponseModel.swift
//  LiteTests
//
//  Created by Roshan Nindrai on 8/4/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
@testable import Lite

struct GetResponse: Codable {
    let args: [String: String]?
    let headers: [String: String]?
    let origin: String?
    let form: [String: String]?
    let url: URL?
}

@objcMembers
public class GetResponseEntity: RealmEntity {
    dynamic var url: String?
    convenience init(_ url: String) {
        self.init()
        self.url = url
    }
}

extension GetResponse: TranslatorProtocol {
    
    typealias PersistedResource = GetResponseEntity

    static func reverseTranslate(_ data: GetResponse) -> GetResponseEntity? {
        return GetResponseEntity(data.url?.absoluteString ?? "No url found")
    }
    
    static func translate(_ data: GetResponseEntity) -> GetResponse? {
        return GetResponse(args: nil, headers: nil, origin: nil, form: nil, url: URL(string: data.url ?? ""))
    }

}
