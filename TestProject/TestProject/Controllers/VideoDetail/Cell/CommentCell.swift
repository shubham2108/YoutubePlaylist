//
//  CommentCell.swift
//  TestProject
//
//  Created by Shubham on 13/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(itemModel: ItemModel) {
        userImage.downloaded(from: itemModel.snippet.topLevelComment.snippet.authorProfileImageUrl)
        name.text = itemModel.snippet.topLevelComment.snippet.authorDisplayName
        comment.text = itemModel.snippet.topLevelComment.snippet.textDisplay
    }
    
}
