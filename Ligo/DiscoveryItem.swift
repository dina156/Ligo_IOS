//
//  DiscoveryItem.swift
//  Ligo
//
//  Created by Mengsroin Heng on 9/11/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import Foundation
class DiscoveryItem{
    var id: Int
    var english: String
    var khmer: String
    var pronunciation: String
    var soundUrl : String
    
    init(id: Int, english: String, khmer: String, pronunciation: String, soundUrl: String) {
        self.id = id
        self.english = english
        self.khmer = khmer
        self.pronunciation = pronunciation
        self.soundUrl = soundUrl
    }
}
