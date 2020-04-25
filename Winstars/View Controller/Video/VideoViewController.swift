//
//  VideoViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 19/4/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Cache
import YoutubeKit

class VideoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, YTSwiftyPlayerDelegate{
    
    @IBOutlet weak var videoTableView: UITableView!
    private var player: YTSwiftyPlayer!
    
    var items: [JSON]?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell
        
        cell.titleLabel?.text =  items?[indexPath.row]["snippet"]["title"].stringValue
//        cell.idLabel?.text = items?[indexPath.row]["contentDetails"]["videoId"].stringValue
        let url = items?[indexPath.row]["snippet"]["thumbnails"]["medium"]["url"].stringValue
        if let _ = items {cell.Indicator.stopAnimating()} else {cell.Indicator.startAnimating()}
        Extension.setImage(from: url ??  "", to: cell.thumbnailImageView!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideoID = items?[indexPath.row]["contentDetails"]["videoId"].stringValue
        player.loadVideo(videoID: selectedVideoID!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create a new player
        player = YTSwiftyPlayer(
            frame: CGRect(x: 0, y: 0, width: 1, height: 1),
            playerVars: [
                .playsInline(false),
                .loopVideo(true),
                .showRelatedVideo(false)
            ])

        // Enable auto playback when video is loaded
        player.autoplay = true
        player.loadPlayer()
        // Set player view
        view.addSubview(player)

        // Set delegate for detect callback information from the player
        player.delegate = self

        
        

        
    }
    
}
