//
//  PlayListModel.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

struct PlayListModel: Decodable {
    var id: String
    var snippet: SnippetModel
    var contentDetails: ContentDetailModel
    
    enum CodingKeys: String, CodingKey {
        case id, snippet, contentDetails
    }
}

struct SnippetModel: Decodable {
    var publishedAt: String
    var title: String
    var channelTitle: String
    var thumbnails: ThumbnailModel?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case publishedAt, title, channelTitle, thumbnails, description
    }
}

struct ThumbnailModel: Decodable {
    var defaultImage: ImageModel
    var medium: ImageModel
    var high: ImageModel
    
    enum CodingKeys: String, CodingKey {
        case defaultImage = "default", medium, high
    }
}


struct ImageModel: Decodable {
    var url: String
    var width: Int
    var height: Int
    
    enum CodingKeys: String, CodingKey {
        case url, width, height
    }
}

struct ContentDetailModel: Decodable {
    var itemCount: Int?
    var videoId: String?
    var count: String {
        return "\(itemCount ?? 0)" + " videos"
    }
    
    enum CodingKeys: String, CodingKey {
        case itemCount, videoId
    }
}
