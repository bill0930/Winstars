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
class VideoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var videoTableView: UITableView!
    
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
        cell.idLabel?.text = items?[indexPath.row]["contentDetails"]["videoId"].stringValue
        let url = items?[indexPath.row]["snippet"]["thumbnails"]["medium"]["url"].stringValue
        if let _ = items {cell.Indicator.stopAnimating()} else {cell.Indicator.startAnimating()}
        Extension.setImage(from: url ??  "", to: cell.thumbnailImageView!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(items?[indexPath.row]["snippet"]["title"].stringValue)
//        print(items?[indexPath.row]["snippet"]["thumbnails"]["medium"]["url"].stringValue)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url =  "https://api.jsonbin.io/b/5e9baf1c2940c704e1daeac7/1"
        
        let diskConfig = DiskConfig(name: "Floppy")
        let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(60*60*5)), countLimit: 10, totalCostLimit: 10)
        
        let storage = try? Storage(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: JSON.self)
        )
        
        if let entry =  try? storage?.entry(forKey: "itemsKey"){
            items = entry.object.array
        }else {
            AF.request(url).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    do {
                        let json = JSON(value)
                        let items = json["items"]
                        
                        try storage?.setObject(items, forKey: "itemsKey")
                        self.items = try storage?.entry(forKey: "itemsKey").object.array
                        self.videoTableView.reloadData()
                    } catch {
                        print(error)
                    }
                    
                case .failure(let error):
                    print(error)
                }
                // Do any additional setup after loading the view.
            }
        }
        
        
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
}

