//
//  EmptyTableView.swift
//  rssReader2
//
//  Created by Tony on 12/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class EmptyTableView: UIView {

    // MARK: - Outlets
    
    @IBOutlet var view: UIView!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // MARK: - Utility
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EmptyTableView", owner: self)
        view.frame = bounds
        view.removeFromSuperview()
        addSubview(view)
    }
    
}
