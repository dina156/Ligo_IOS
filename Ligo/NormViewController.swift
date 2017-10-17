//
//  NormViewController.swift
//  Ligo
//
//  Created by Mengsroin Heng on 28/8/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit

class NormViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var norms = [Norm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // load data from server
        loadDataFromServer()
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        // Do your job, when done:
        print("Reload data")
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return norms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_norm") as! NormTableViewCell
        let norm = norms[indexPath.row]
        cell.titleLabel.text = norm.title
        cell.typeLabel.text = norm.type
        cell.detailLabel.text = norm.detail
        let imageUrl = URL(string: norm.thumbnailImage)!
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if (error != nil){
                print("Load category error: ", error!.localizedDescription)
            }else{
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    cell.normImageView.image = image
                }
            }
        }
        task.resume()
        return cell
    }
    
    // tableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User click on index: ", indexPath.row)
    }

    
    func loadDataFromServer() {
        print("Start in loadDataFromServer")
//        let normUrl = URL(string: "https://ligo54.000webhostapp.com/getNormsIOS")!
        let normUrl = URL(string: "http://ligo.ga/api/getNormsIOS")!
//        let normUrl = URL(string: "http://127.0.0.1:8000/getNorms")!
        let task = URLSession.shared.dataTask(with: normUrl){(data, response, error) in
            if (error != nil){
                print("Load category error: ", error!.localizedDescription)
            }else{
                self.deserialiseDate(data: data!)
            }
        }
        task.resume()
        
    }
    
    func deserialiseDate(data: Data){
        print("Deserialising data")
        var normsFromServer = [Norm]()
        let items = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
        for item in items {
            let normDictionary = item as! [String:Any]
            let id = normDictionary["id"] as! Int
            let title = normDictionary["title"] as! String
            let type = normDictionary["type"] as! String
            let detail = normDictionary["description"] as! String
            let thumbnailUrl = normDictionary["thumbnailUrl"] as! String
            let norm = Norm(id: id, type: type, title: title, detail: detail, thumbnailImage: thumbnailUrl)
            normsFromServer.append(norm)
        }
        norms = normsFromServer
        DispatchQueue.main.async {
            print("Reload data")
            self.tableView.reloadData()
        }
    }
}
