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
    
    let districts = ["Hong Kong", "Taiwan", "Korea", "Japan", "Singopore"]
    let titles = ["明明就", "說了再見", "大笨鐘", "hello"]
    var items: [JSON]?
    var selectedDistrict: String?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "districtCell", for: indexPath) as! DistrictTableViewCell
        cell.districtLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let querySring = titles[indexPath.row]
        selectedDistrict = querySring
        let filteredItems = items?.filter({ (item) -> Bool in
            item["snippet"]["title"].stringValue.contains(querySring)
        })
        print(filteredItems)
        self.performSegue(withIdentifier: "toVideoVC", sender: filteredItems)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        let url =  "https://api.jsonbin.io/b/5e9baf1c2940c704e1daeac7/1"
        
        let diskConfig = DiskConfig(name: "Floppy")
        let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(60*60*24)), countLimit: 10, totalCostLimit: 10)
        
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
