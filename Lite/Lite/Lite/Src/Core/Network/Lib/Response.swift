//
//  Response.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public enum Response<Resource> {
    case success(Resource?, (Data, URLResponse))
    case failure(Error)
}

public struct ResponseCallback<Resource> {
    let handler: (Response<Resource>) -> Void
}
