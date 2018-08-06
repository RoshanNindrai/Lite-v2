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

/*
 
 "args": {},
 "headers": {
 "Accept": "",
 "Accept-Encoding": "gzip, deflate",
 "Cache-Control": "no-cache",
 "Connection": "close",
 "Host": "httpbin.org",
 "Postman-Token": "0fdfb915-2a4a-4580-98eb-9f237a98bcda",
 "User-Agent": "PostmanRuntime/7.1.1"
 },
 "origin": "108.69.132.164",
 "url": "https://httpbin.org/get"
 
 */
struct GetResponse: Codable {
    let args: [String: String]?
    let headers: [String: String]?
    let origin: String?
    let form: [String: String]?
    let url: URL?
}

@objcMembers
public class GetResponseRealm: Cacheable {
    dynamic var url: String?
    convenience init(_ url: String) {
        self.init()
        self.url = url
    }
}

extension GetResponse: TranslatorProtocol {

    static func reverseTranslate(_ data: GetResponse) -> GetResponseRealm? {
        return GetResponseRealm.init(data.url?.absoluteString ?? "No url found")
    }

    typealias PersistedResource = GetResponseRealm
    static func translate(_ data: GetResponseRealm) -> GetResponse? {
        return GetResponse(args: nil, headers: nil, origin: nil, form: nil, url: URL(string: data.url ?? ""))
    }

}
