//
//  TableViewCell.swift
//  rssReader2
//
//  Created by Tony on 10/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
