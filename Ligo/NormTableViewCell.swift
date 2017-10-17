//
//  NormTableViewCell.swift
//  Ligo
//
//  Created by Mengsroin Heng on 30/8/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit

class NormTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var normImageView: UIImageView!

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parentView.layer.cornerRadius = 5
        parentView.layer.masksToBounds = true
    }
}
