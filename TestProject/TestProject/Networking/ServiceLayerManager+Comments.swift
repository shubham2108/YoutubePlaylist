//
//  ServiceLayerManager+Comments.swift
//  TestProject
//
//  Created by Shubham on 13/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

extension ServiceLayerManager {
    
    // Comment list API call
    class func getCommentList(videoId: String, nextPage: String, completionHandler: @escaping (_ comments: CommentModel?, _ error: String?) -> ()) {
        var url = COMMENT_LIST_URL+videoId
        if !nextPage.isEmpty {
            url = url+"&pageToken="+nextPage
        }
        request(url, method: .get, parameters: nil, headers: nil) { (responseData, errorString) in
            if let responseData = responseData, let jsonData = responseData.data, responseData.result.isSuccess {
                do {
                    let channelModel = try JSONDecoder().decode(CommentModel.self, from: jsonData)
                    completionHandler(channelModel, nil)
                } catch {
                    print(error)
                    completionHandler(nil, error.localizedDescription)
                }
            }else {
                completionHandler(nil, errorString?.error)
            }
        }
    }
}
