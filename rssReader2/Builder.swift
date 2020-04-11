//
//  Builder.swift
//  rssReader2
//
//  Created by Tony on 11/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class Builder {
    
    static func getFeedViewController() -> FeedViewControllerProtocol {
        let viewController: FeedViewController = UIStoryboard.makeViewController(storyboardName: "Main")
        let loader = FeedLoader()
        let presenter = FeedPresenter(viewController: viewController,
                                      feedLoader: loader)
        viewController.presenter = presenter
        
        return viewController
    }
}
