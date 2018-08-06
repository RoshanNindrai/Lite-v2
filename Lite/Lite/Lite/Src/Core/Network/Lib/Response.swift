//
//  Response.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/21/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

public enum Response<Resource> {
    case success(Resource?)
    case failure(Error)
}

public struct ResponseCallback<Resource> {
    let handler: (Response<Resource>) -> Void

    func handle(_ response: Response<Resource>) {
        handler(response)
    }

}
