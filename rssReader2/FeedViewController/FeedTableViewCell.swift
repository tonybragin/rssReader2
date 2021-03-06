//
//  TableViewCell.swift
//  rssReader2
//
//  Created by Tony on 10/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionTextView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            titleLabel.numberOfLines = 0
            descriptionTextView.isHidden = false
        } else {
            titleLabel.numberOfLines = 2
            descriptionTextView.isHidden = true
        }
    }
    
    // MARK: - Public
    
    func configure(for item: FeedDataItemProtocol) {
        if let imageString = item.imagePath,
            let imageURL = URL(string: imageString) {
            sourceImageView.kf.setImage(with: imageURL)
        }
        
        sourceLabel.text = item.source
        titleLabel.text = item.title
        descriptionTextView.text = item.description
    }
}
