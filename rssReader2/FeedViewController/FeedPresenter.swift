//
//  FeedPresenter.swift
//  rssReader2
//
//  Created by Tony on 11/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol FeedPresenterProtocol {
    init (viewController: FeedViewControllerProtocol,
          feedLoader: FeedLoaderProtocol)
    
    func addButtonTouched()
}

class FeedPresenter: FeedPresenterProtocol {
    
    private weak var viewController: FeedViewControllerProtocol?
    private var feedLoader: FeedLoaderProtocol
    
    required init (viewController: FeedViewControllerProtocol,
                   feedLoader: FeedLoaderProtocol) {
        self.viewController = viewController
        self.feedLoader = feedLoader
    }
    
    func addButtonTouched() {
        viewController?.presentAddFeedAlert(complition: { [weak self] (path) in
            if let path = path {
                self?.feedLoader.getItems(for: path, complition: { (result) in
                    switch result {
                    case .success(let items):
                        if let viewController = self?.viewController {
                            var feedData = viewController.feedData
                            feedData.append(contentsOf: items)
                            feedData.sort { (first, second) -> Bool in
                                if let firstDate = first.publicationDay,
                                    let secondDate = second.publicationDay {
                                    return firstDate < secondDate
                                }
                                return false
                            }
                            viewController.feedData = feedData
                        }
                    case .failure(let error):
                        self?.viewController?.alert(title: "Error",
                                                    message: error.description)
                    }
                })
            }
        })
    }
}
