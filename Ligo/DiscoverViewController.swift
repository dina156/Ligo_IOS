//
//  DiscoverViewController.swift
//  Ligo
//
//  Created by Mengsroin Heng on 28/8/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
//    let categories = ["Family", "Restaurant", "Hotel", "Food", "Travel"]
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        // assign datasource
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
    
    // required function for tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // required function for tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_category") as! CategoryTableViewCell
        let category = categories[indexPath.row]
        cell.titleLabel.text = category.title
//        print("ImageURL: ", category.thumbnailUrl)
        let imageUrl = URL(string: category.thumbnailUrl)!
        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if (error != nil){
                print("Load category error: ", error!.localizedDescription)
            }else{
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    cell.iconImageView.image = image
                }
            }
        }
        task.resume()
        
        return cell
    }
    
    // tableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Segue_discovery_item", sender: indexPath)
        print("User click on index: ", indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let discoveryItemView = segue.destination as! DiscoveryItemTableViewController
        let indexPath = sender as! IndexPath
        print("Index: ", indexPath.row)
        let category = categories[indexPath.row]
        discoveryItemView.titleLabel.title = category.title
        discoveryItemView.categoryId = category.id
    }
    
    func loadDataFromServer() {
        print("Start in loadDataFromServer")
//        let categoryUrl = URL(string: "https://ligo54.000webhostapp.com/getCategoriesDiscover")!
        let categoryUrl = URL(string: "http://ligo.ga/api/getCategoriesDiscover")!
//        let categoryUrl = URL(string: "http://127.0.0.1:8000/getCategories")!
        let task = URLSession.shared.dataTask(with: categoryUrl){(data, response, error) in
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
        var categoriesFromServer = [Category]()
        let items = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
        for item in items {
            let categoryDictionary = item as! [String:Any]
            let id = categoryDictionary["id"] as! Int
            let title = categoryDictionary["title"] as! String
            let thumbnailUrl = categoryDictionary["thumbnailUrl"] as! String
            let category = Category(id: id, title: title, thumbnailUrl: thumbnailUrl)
            categoriesFromServer.append(category)
        }
        categories = categoriesFromServer
        DispatchQueue.main.async {
            print("Reload data")
            self.tableView.reloadData()
        }
    }
    
}
