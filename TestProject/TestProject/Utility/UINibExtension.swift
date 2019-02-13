//
//  UINibExtension.swift
//  TestProject
//
//  Created by Shubham on 08/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import UIKit

// MARK: - UITableViewCell Nib
extension UINib {
    
    class func playlistCellNib() -> UINib {
        return UINib(nibName: Cell.playlistCell.rawValue, bundle:nil)
    }
    
    class func detailCellNib() -> UINib {
        return UINib(nibName: Cell.detailCell.rawValue, bundle:nil)
    }
    
}
