//
//  PlayListViewController.swift
//  TestProject
//
//  Created by Shubham on 12/02/19.
//  Copyright © 2019 PlaySports. All rights reserved.
//

import UIKit

enum ViewMode {
    case playlists
    case videos
}

class PlayListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var viewMode: ViewMode = .playlists
    
    var channelModel: ChannelModel? {
        didSet{
            tableView.reloadData()
        }
    }
    
    var playlistID = ""
    
    //To check if api call is running to fetch video list or not
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    //Configure view controller here
    fileprivate func configureView() {
        //Set view title here
        title = viewTitle
        
        //Register tableview with cell here
        tableView.register(UINib.playlistCellNib(), forCellReuseIdentifier: Cell.playlistCell.identifier)
        tableView.tableFooterView = UIView(frame: .zero)
        
        //Get channel playlists or playlist's videos based on the view mode
        switch viewMode {
        case .playlists:
            getChannelPlaylist()
        default:
            getVideoList(playlistID)
        }
    }
    
    
    //This function is checking if playlist has more videos to load then fetch them
    func loadMoreVideos(_ indexPath: IndexPath) {
        if let channel = channelModel, let token = channel.nextPageToken, !isLoading {
            let numberOfItems = channel.items.count
            let currentItem = indexPath.row
            if currentItem > numberOfItems - preloadMargin {
                isLoading = true
                getVideoList(playlistID, nextPage: token)
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PlayListViewController, let playlistId = sender as? String {
            viewController.playlistID = playlistId
            viewController.viewMode = .videos
        }else if let viewController = segue.destination as? DetailViewController, let playlistModel = sender as? PlayListModel {
            viewController.playListModel = playlistModel
        }
    }
    

}

// MARK: - Identifiers
extension PlayListViewController {
    
    var viewTitle: String {
        switch viewMode {
        case .playlists:
            return "GMBN Playlist"
        default:
            return "Videos List"
        }
        
    }
    
    var preloadMargin: Int {
        return 20
    }
    
    struct Table {
        static let cellHeight: CGFloat = 100
        static let numberOfSection = 1
    }
    
    enum Segue: String {
        case videosSegue
        case detailSegue
        var identifier: String {
            switch self {
            case .videosSegue:
                return "videosSegue"
            case .detailSegue:
                return "detailSegue"
            }
        }
    }
}


// MARK: - Tableview controller data source and Delegates
extension PlayListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Table.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channelModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Table.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        loadMoreVideos(indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cell.playlistCell.identifier) as? PlaylistCell {
            if let channel = channelModel{
                cell.configureCell(playList: channel.items[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let channel = channelModel{
            switch viewMode {
            case .playlists:
                performSegue(withIdentifier: Segue.videosSegue.identifier, sender: channel.items[indexPath.row].id)
            default:
                performSegue(withIdentifier: Segue.detailSegue.identifier, sender: channel.items[indexPath.row])
            }
        }
    }
    
}


//MARK:- Extension for API call
extension PlayListViewController {
    
    //API call to get channel playlists
    func getChannelPlaylist() {
        let loadingView = displayActivityIndicator(onView: view)
        ServiceLayerManager.getPlaylist { [weak self] (channel, error) in
            guard let strongSelf = self else { return }
            strongSelf.removeActivityIndicator(loadingView)
            if let channel = channel {
                strongSelf.channelModel = channel
            }else {
                strongSelf.showAlert(message: error ?? "", completionHandler: { (alertAction) in
                    if alertAction.style == .default {
                        strongSelf.getChannelPlaylist()
                    }
                })
            }
        }
    }
    
    //API call to get playlist's videos
    func getVideoList(_ playlistId: String, nextPage: String = "") {
        let loadingView = displayActivityIndicator(onView: view)
        ServiceLayerManager.getVideolist(playlistId: playlistId, nextPage: nextPage) { [weak self] (channel, error) in
            guard let strongSelf = self else { return }
            strongSelf.removeActivityIndicator(loadingView)
            strongSelf.isLoading = false
            if let channel = channel {
                strongSelf.appendVideos(channel)
            }else {
                strongSelf.showAlert(message: error ?? "", completionHandler: { (alertAction) in
                    if alertAction.style == .default {
                        strongSelf.getVideoList(playlistId, nextPage: nextPage)
                    }
                })
            }
        }
    }
    
    //This function is appending new videos list with already featched videos list
    private func appendVideos(_ newChannelModel: ChannelModel) {
        if var oldChannelModel = channelModel {
            oldChannelModel.pageInfo = newChannelModel.pageInfo
            oldChannelModel.nextPageToken = newChannelModel.nextPageToken
            oldChannelModel.items = oldChannelModel.items + newChannelModel.items
            channelModel = oldChannelModel
        }else {
            channelModel = newChannelModel
        }
    }
}
