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
            return "/group"
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
            return ["Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjZiMDBiZjc2ZTA0NTNiOGI1YzdkZWQiLCJlbWFpbCI6Imh1eW5odm9ob2FuZ25hbTcxNEBnbWFpbC5jb20iLCJyb2xlIjoibWVtYmVyIiwiZGlzcGxheV9uYW1lIjoiaG9hbmduYW12aW5vdmEiLCJpYXQiOjE2MDEyODQ0ODAsImV4cCI6MTYwMTI4ODA4MH0.61yqj3w-0NnzpVtQMwHLGmrQok5npuN2Ybyo8gj1rvQ"]
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
