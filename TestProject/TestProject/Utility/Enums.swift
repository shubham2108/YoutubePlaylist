//
//  Enums.swift
//  TestProject
//
//  Created by Shubham on 08/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import Foundation

enum Cell: String {
    case playlistCell = "PlaylistCell"
    case detailCell = "DetailCell"
    
    var identifier: String {
        switch self {
        case .playlistCell:
            return "videoCell"
        case .detailCell:
            return "detailCell"
        }
    }
}
