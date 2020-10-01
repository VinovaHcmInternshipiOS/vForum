//
//  FeedCallAPIMethod.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/30/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation
import Alamofire

enum FeedMethod : TargetType {
    case query
    case createFeed(description: String, attachments: [String])
    case editFeed(feedID: String, description: String, attachments: [String])
    case deleteFeed(feedID: String)
    case addLike(feedID: String)
    case minusLike(feedID: String)
    
    case queryComment(feedID: String)
    case addComment(feedID: String, description: String)
    case editComment(feedID: String, commentID: String, description: String)
    case deleteComment(feedID: String, commentID: String)
    case addLikeComment(feedID: String, commentID: String)
    case minusLikeComment(feedID: String, commentID: String)
    
    var path: String {
        switch self {
        case .query:
            return "/feed"
        case .addLike(let feedID):
            return "/feed/\(feedID)/addlike"
        case .minusLike(let feedID):
            return "/feed/\(feedID)/minuslike"
        case .createFeed:
            return "/feed"
        case .editFeed(let feedID, _, _):
            return "/feed/\(feedID)"
        case .deleteFeed(let feedID):
            return "/feed/\(feedID)"
        case .queryComment(let feedID):
            return "/feed/\(feedID)/comment"
        case .addComment(let feedID, _):
            return "/feed/\(feedID)/comment"
        case .editComment(let feedID, let commentID ,_):
            return "/feed/\(feedID)/comment/\(commentID)"
        case .deleteComment(let feedID, let commentID):
            return "/feed/\(feedID)/comment/\(commentID)"
        case .addLikeComment(let feedID, let commentID):
            return "/feed/\(feedID)/comment/\(commentID)"
        case .minusLikeComment(let feedID, let commentID):
            return "/feed/\(feedID)/comment/\(commentID)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .query, .queryComment:
            return .get
        case .addLike, .minusLike, .editFeed, .addLikeComment, .minusLikeComment, .editComment:
            return .patch
        case .createFeed, .addComment:
            return .post
        case .deleteFeed, .deleteComment:
            return .delete
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .query, .addLike, .minusLike, .deleteFeed, .queryComment, .addLikeComment, .minusLikeComment, .deleteComment:
            return nil
        case .createFeed(let description, let attachments):
            return ["description": description, "attachments": attachments]
        case .editFeed(_, let description, let attachments):
            return ["description": description, "attachments": attachments]
        case .addComment(_, let description):
            return ["description": description]
        case .editComment(_, _, let description):
            return ["description": description]
        }
    }
    
    var headers: [String : String]? {
            return nil
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .query, .queryComment:
            return URLEncoding(destination: .queryString)
        default:
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        return .request
    }
}

enum FeedAppServerConfiguration: AppServerConfiguration{
    var baseURL: String {
        return "http://localhost:4000/v1/api"
    }
    
    var defaultHeaders: [String : String] {
        return [:]
    }
    
    case allTime
}
