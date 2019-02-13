//
//  PlaylistCell.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import UIKit
import Alamofire

class PlaylistCell: UITableViewCell {
    
    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var videosCount: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(playList: PlayListModel) {
        playlistImage.downloaded(from: playList.snippet.thumbnails?.defaultImage.url ?? "")
        title.text = playList.snippet.title
        if let _ = playList.contentDetails.itemCount {
            videosCount.text = playList.contentDetails.count
        }else {
            videosCount.text = Utility.getFormatedDate(playList.snippet.publishedAt)
        }
        
    }
    
}
