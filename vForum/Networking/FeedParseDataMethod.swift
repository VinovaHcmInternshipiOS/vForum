//
//  FeedParseDataMethod.swift
//  vForum
//
//  Created by CATALINA-ADMIN on 9/30/20.
//  Copyright © 2020 vinova.internship. All rights reserved.
//

import Foundation

struct FeedRequestMethod: Decodable {
    let result: [FeedHomeRequest]?
    let code: Int?
    let error: String?
    let options: String?
    let success: Int?
}

struct FeedHomeRequest: Decodable {
    let _id: String?
    let attachments: [String]?
    let avatar: String?
    let commentsFeed: [FeedComment]?
    let countCommentFeed: Int?
    let countLike: Int?
    let createdAt: String?
    let createdBy: String?
    let description: String?
    let flags: [String]?
    let userId: String?
}

struct FeedComment: Decodable {
    let __v: Int?
    let _id: String?
    let countLike: Int?
    let createdAt: String?
    let createdBy: String?
    let description: String?
    let feedId: String?
    let isUpdated: Bool?
    let status: String?
    let updateAt: String?
    let avatar: String?
}
