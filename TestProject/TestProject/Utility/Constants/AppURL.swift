//
//  AppURL.swift
//  TestProject
//
//  Created by Shubham on 09/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

//ClientId for login
fileprivate let channel_Id = "UC_A--fhX5gea0i4UtpD99Gg"
fileprivate let app_Key = "AIzaSyC3DmxlXD-V1_KeVP3bNPnC141h5S9Bxwc"
fileprivate let max_Results = "50"
fileprivate let orderBy = "date"
fileprivate let part = "snippet,contentDetails"


// App URLs for application

let BASE_URL = "https://www.googleapis.com/youtube/v3/"
let PLAY_LISTS_URL = BASE_URL+"playlists?part="+part+"&order="+orderBy+"&key="+app_Key+"&maxResults="+max_Results+"&channelId="+channel_Id

let VIDEO_LIST_URL = BASE_URL+"playlistItems?part="+part+"&order="+orderBy+"&key="+app_Key+"&maxResults="+max_Results+"&playlistId="



