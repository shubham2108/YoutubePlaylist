//
//  ServiceLayerManager+Playlist.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

extension ServiceLayerManager {
    
    // Playlist API call
    class func getPlaylist(nextPage: String = "", completionHandler: @escaping (_ adherences: ChannelModel?, _ error: String?) -> ()) {
        let url = PLAY_LISTS_URL
        request(url, method: .get, parameters: nil, headers: nil) { (responseData, errorString) in
            if let responseData = responseData, let jsonData = responseData.data, responseData.result.isSuccess {
                do {
                    let channelModel = try JSONDecoder().decode(ChannelModel.self, from: jsonData)
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
