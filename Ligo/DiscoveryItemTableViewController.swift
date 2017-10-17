//
//  DiscoveryItemTableViewController.swift
//  Ligo
//
//  Created by Mengsroin Heng on 9/6/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit
import AVFoundation

class DiscoveryItemTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UINavigationItem!

    var categoryId: Int = 0
    var discoveryItems = [DiscoveryItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromServer(categoryId: categoryId)
    }
    
    
    @IBAction func onRefreshPulled(_ sender: Any) {
        print("Reload data")
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveryItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Index: ", indexPath.row)
        let soundUrl = self.discoveryItems[indexPath.row].soundUrl
        playAudio(url: soundUrl)
    }
    
    func playAudio(url : String){
        print("playing \(url)")
        let MyUrl = URL(string: url)
        let player = AVPlayer(url: MyUrl!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_discovery_item") as! DiscoveryItemTableViewCell
        let item = discoveryItems[indexPath.row]
        cell.englishLable.text = item.english
        cell.khmerLable.text = item.khmer
        cell.pronunciationLable.text = item.pronunciation
        return cell
    }
    
    func loadDataFromServer(categoryId: Int) {
        refreshControl?.beginRefreshing()
        refreshControl?.layoutIfNeeded()
        print("Start in loadDataFromServer")
//        let categoryUrl = URL(string: "https://ligo54.000webhostapp.com/getItemsByCategory/\(categoryId)" )!
        let categoryUrl = URL(string: "http://ligo.ga/api/getItemsByCategory/\(categoryId)" )!
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
        var ItemsFromServer = [DiscoveryItem]()
        let items = try! JSONSerialization.jsonObject(with: data, options: []) as! [Any]
        for item in items {
            let itemsDictionary = item as! [String:Any]

            let english = itemsDictionary["english"] as! String
            let khmer = itemsDictionary["khmer"] as! String
            let pronunciation = itemsDictionary["pronunciation"] as! String
            let soundUrl = itemsDictionary["sound"] as! String
            let item = DiscoveryItem(id: 1, english: english, khmer: khmer, pronunciation: pronunciation, soundUrl: soundUrl)
            ItemsFromServer.append(item)
        }
        discoveryItems = ItemsFromServer
        DispatchQueue.main.async {
            print("Reload data")
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
}
