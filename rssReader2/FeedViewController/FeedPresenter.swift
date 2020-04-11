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
    
    func viewDidLoad()
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
    
    func viewDidLoad() {
        
    }
    
    func addButtonTouched() {
        viewController?.presentAddFeedAlert(complition: { [weak self] (path) in
            if let path = path {
                self?.feedLoader.getItems(for: path, complition: { (result) in
                    switch result {
                    case .success(let items):
                        self?.viewController?.feedData = items
                    case .failure(let error):
                        self?.viewController?.alert(title: "Error",
                                                    message: error.description)
                    }
                })
            }
        })
    }
}
