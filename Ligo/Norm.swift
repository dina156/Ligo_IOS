//
//  Norm.swift
//  Ligo
//
//  Created by Mengsroin Heng on 28/8/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import Foundation
class Norm {
    var id: Int
    var type: String
    var title: String
    var detail: String
    var thumbnailImage: String
    
    init(id: Int, type: String, title: String, detail: String, thumbnailImage: String) {
        self.id = id
        self.type = type
        self.title = title
        self.detail = detail
        self.thumbnailImage = thumbnailImage
    }
}
