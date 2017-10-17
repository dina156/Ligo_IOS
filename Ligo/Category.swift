//
//  Category.swift
//  Ligo
//
//  Created by Mengsroin Heng on 28/8/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import Foundation
class Category {
    var id : Int
    var title : String
    var thumbnailUrl: String
    init(id: Int, title: String, thumbnailUrl: String) {
        self.id = id
        self.title = title
        self.thumbnailUrl = thumbnailUrl
    }
}
