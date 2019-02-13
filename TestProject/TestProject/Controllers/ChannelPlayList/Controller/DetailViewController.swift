//
//  DetailViewController.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var videoTitle: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var publishedDate: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    
    var playListModel: PlayListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //Configure view controller here
    fileprivate func configureView() {
        //Set view title here
        title = viewTitle
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Table.cellHeight
        //Register tableview with cell here
        tableView.register(UINib.detailCellNib(), forCellReuseIdentifier: Cell.detailCell.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        
        
        if let playListModel = playListModel {
            imageView.downloaded(from: playListModel.snippet.thumbnails?.medium.url ?? "")
            videoTitle.text = playListModel.snippet.title
            publishedDate.text = Utility.getFormatedDate(playListModel.snippet.publishedAt)
        }
    }

}

// MARK: - Identifiers
extension DetailViewController {
    
    var viewTitle: String {
        return "Video Details"
    }
    
    struct Table {
        static let cellHeight: CGFloat = 100
        static let numberOfSection = 1
        static let numberOfCells = 1
    }
}

// MARK: - Tableview controller data source and Delegates
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Table.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Table.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.detailCell.identifier) as? DetailCell {
            if let playListModel = playListModel {
                cell.detailLabel.text = playListModel.snippet.description
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
