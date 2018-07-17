//
//  HTTPMethod.swift
//  Lite
//
//  Created by Roshan Nindrai on 7/17/18.
//  Copyright © 2018 Roshan Nindrai. All rights reserved.
//

import Foundation

/// This represent the kind of network activity that is gonna takes place
///
/// - POST:   used for a post request
/// - GET:    used for a get request
/// - DELETE: used for a delete request
/// - PUT:    used for a put request
public enum HTTPMethod<Body> {
    case get
    case post(Body)
    case delete(Body)
    case put(Body)
}

extension HTTPMethod {
    
    /// Return the http method as string
    var method : String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .delete: return "DELETE"
        case .put: return "PUT"
        }
    }
}
