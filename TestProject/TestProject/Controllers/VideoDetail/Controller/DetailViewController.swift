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
    
    private var commentModel: CommentModel? {
        didSet{
            tableView.reloadData()
        }
    }
    
    private var videoId: String {
        return playListModel?.contentDetails.videoId ?? ""
    }
    
    //To check if api call is running to fetch video list or not
    private var isLoading = false
    
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
        tableView.register(UINib.commentCellNib(), forCellReuseIdentifier: Cell.commentCell.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        
        
        if let playListModel = playListModel {
            imageView.downloaded(from: playListModel.snippet.thumbnails?.medium.url ?? "")
            videoTitle.text = playListModel.snippet.title
            publishedDate.text = Utility.getFormatedDate(playListModel.snippet.publishedAt)
        }
        
        getCommentList(videoId)
    }
    
    //This function is checking if video has more comment to load. if yes, then fetch them
    func loadMoreComments(_ indexPath: IndexPath) {
        if let comment = commentModel, let token = comment.nextPageToken, !isLoading {
            let numberOfItems = comment.items.count
            let currentItem = indexPath.row
            if currentItem > numberOfItems - preloadMargin {
                isLoading = true
                getCommentList(videoId, nextPage: token)
            }
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
        static let numberOfSection = 2
        static let numberOfCells = 1
    }
    
    var preloadMargin: Int {
        return 20
    }
    
    var sectionTitle: [String] {
        return ["", "Comments"]
    }
}

// MARK: - Tableview controller data source and Delegates
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Table.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  section == 0 ? Table.numberOfCells : commentModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return configureDetailSection(indexPath: indexPath)
        default:
            return configureCommentsSection(indexPath: indexPath)
        }
    }
    
    //function to configure detail section
    private func configureDetailSection(indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.detailCell.identifier) as? DetailCell {
            if let playListModel = playListModel {
                cell.detailLabel.text = playListModel.snippet.description
            }
            return cell
        }
        return UITableViewCell()
    }
    
    //function to configure comments section
    private func configureCommentsSection(indexPath: IndexPath) -> UITableViewCell {
        loadMoreComments(indexPath) // To load more comments
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.commentCell.identifier) as? CommentCell {
            if let commentModel = commentModel {
                cell.configureCell(itemModel: commentModel.items[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
}


//MARK:- Extension for API call
extension DetailViewController {
    
    
    //API call to get playlist's videos
    func getCommentList(_ videoId: String, nextPage: String = "") {
        let loadingView = displayActivityIndicator(onView: tableView)
        ServiceLayerManager.getCommentList(videoId: videoId, nextPage: nextPage) { [weak self] (commentModel, error) in
            guard let strongSelf = self else { return }
            strongSelf.removeActivityIndicator(loadingView)
            strongSelf.isLoading = false
            if let comments = commentModel {
                strongSelf.appendComments(comments)
            }else {
                strongSelf.showAlert(message: error ?? "", completionHandler: { (alertAction) in
                    if alertAction.style == .default {
                        strongSelf.getCommentList(videoId, nextPage: nextPage)
                    }
                })
            }
        }
    }
    
    //This function is appending new comments with already featched comment
    private func appendComments(_ newModel: CommentModel) {
        if var oldModel = commentModel {
            oldModel.nextPageToken = newModel.nextPageToken
            oldModel.items = oldModel.items + newModel.items
            commentModel = oldModel
        }else {
            commentModel = newModel
        }
    }
}

