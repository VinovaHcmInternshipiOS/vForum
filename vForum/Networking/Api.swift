//
//  Api.swift
//  vForum
//
//  Created by vinova on 28/09/2020.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import Alamofire

enum GroupResult : TargetType {
    var path: String {
        switch self {
        case .group:
            return "/feed"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .group:
            return .get
        default:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .group:
            return nil
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .group:
            return nil
//            return ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1Zjc0NDJkZTExZDBkMjY3MzcwNTNmYjgiLCJlbWFpbCI6ImN1cnRpc0BnbWFpbC5jb20iLCJyb2xlIjoibWVtYmVyIiwiZGlzcGxheV9uYW1lIjoiY3VydGlzIiwiaWF0IjoxNjAxNDU0ODI3LCJleHAiOjE2MDE0NTg0Mjd9.PQCLSEEbhdm21r4jri8tYYxbo-Bm88rqkdNIWjfLtPA"]
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .group:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        return .request
    }
    
    case group
}


enum AppsevicesConfiguration : AppServerConfiguration{
    var baseURL: String {
        return "http://localhost:4000/v1/api"
    }
    
    var defaultHeaders: [String : String] {
        return [:]
    }
    
    case deverloper
}
