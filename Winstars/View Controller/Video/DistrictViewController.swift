//
//  DistrictViewController.swift
//  Winstars
//
//  Created by CHAN CHI YU on 26/4/2020.
//  Copyright © 2020 Billy Chan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Cache
import YoutubeKit

class DistrictViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //Please Replace your own API Key
    let API_KEY = "AIzaSyDCQU46EIUgYtRh-ewY81tckVHAhbr5UMk"

    //Please define your districts here
    let districts = ["自動販賣機", "鋼琴", "夾公仔", "hello"]
    
    var items: [JSON]?
    var selectedDistrict: String?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return districts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "districtCell", for: indexPath) as! DistrictTableViewCell
        cell.districtLabel.text = districts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let querySring = districts[indexPath.row]
        selectedDistrict = querySring
        let filteredItems = items?.filter({ (item) -> Bool in
            item["snippet"]["title"].stringValue.contains(querySring)
        })
        self.performSegue(withIdentifier: "toVideoVC", sender: filteredItems)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        let url =  "https://www.googleapis.com/youtube/v3/playlistItems"
        let playlistID = "PLdqf9f9QD5h5kfwLj5dINs-BPWHHpTu8Z"
        let parameters = [
            "part": "contentDetails, id, snippet",
            "maxResults": "50",
            "playlistId": playlistID,
            "key": API_KEY
        ]
        
        //Cache Definition for 0.1 Hours = 6min
        let diskConfig = DiskConfig(name: "Floppy")
        let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(60*60*0.1)), countLimit: 10, totalCostLimit: 10)
        
        let storage = try? Storage(
            diskConfig: diskConfig,
            memoryConfig: memoryConfig,
            transformer: TransformerFactory.forCodable(ofType: JSON.self)
        )
        
        if let entry =  try? storage?.entry(forKey: "itemsKey"){
            items = entry.object.array
        }else {
            //Requesting API
            AF.request(url, parameters: parameters).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let json = JSON(value)
                        let items = json["items"]
                        try storage?.setObject(items, forKey: "itemsKey")
                        self.items = try storage?.entry(forKey: "itemsKey").object.array
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
                // Do any additional setup after loading the view.
            }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let videoVC = segue.destination as? VideoViewController
        videoVC!.items = sender as! [JSON]
        videoVC?.title = selectedDistrict
    }
}
