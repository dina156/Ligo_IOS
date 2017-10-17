//
//  DiscoveryItemTableViewCell.swift
//  Ligo
//
//  Created by Mengsroin Heng on 9/11/17.
//  Copyright © 2017 Mengsroin Heng. All rights reserved.
//

import UIKit

class DiscoveryItemTableViewCell: UITableViewCell {
    @IBOutlet weak var englishLable: UILabel!
    @IBOutlet weak var khmerLable: UILabel!
    @IBOutlet weak var pronunciationLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
