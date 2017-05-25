//
//  ResultFoundCell.swift
//  iTunesSearch
//
//  Created by LinuxPlus on 5/10/17.
//  Copyright © 2017 LinuxPlus. All rights reserved.
//

import UIKit

class ResultFoundCell: UITableViewCell {

    @IBOutlet weak var itemSubtitle: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImage: AsyncImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
