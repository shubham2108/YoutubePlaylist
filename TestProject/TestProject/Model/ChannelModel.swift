//
//  ChannelModel.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

//Channel model to parse channel info
struct ChannelModel: Decodable {
    var pageInfo: PageModel
    var items: [PlayListModel]
    var nextPageToken: String?
    
    enum CodingKeys: String, CodingKey {
        case pageInfo, items, nextPageToken
    }
}

struct PageModel: Decodable {
    var totalResults: Int
    var resultsPerPage: Int
    
    enum CodingKeys: String, CodingKey {
        case totalResults, resultsPerPage
    }
}




