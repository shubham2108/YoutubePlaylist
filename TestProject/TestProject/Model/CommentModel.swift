//
//  CommentModel.swift
//  TestProject
//
//  Created by Shubham on 13/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

//Comment model to parse comment json info
struct CommentModel: Decodable {
    var items: [ItemModel]
    var nextPageToken: String?
    
    enum CodingKeys: String, CodingKey {
        case items, nextPageToken
    }
}

struct ItemModel: Decodable {
    var snippet: SnippetDetail
    
    struct SnippetDetail: Decodable {
        var videoId: String
        var topLevelComment: TopCommentModel
        
        struct TopCommentModel: Decodable {
            var snippet: SnippetDetail
            
            struct SnippetDetail: Decodable {
                var authorDisplayName: String
                var authorProfileImageUrl: String
                var textDisplay: String
                
                enum CodingKeys: String, CodingKey {
                    case authorDisplayName, authorProfileImageUrl, textDisplay
                }
            }

            enum CodingKeys: String, CodingKey {
                case snippet
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case videoId, topLevelComment
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case snippet
    }
}






