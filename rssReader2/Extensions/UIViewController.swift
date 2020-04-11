//
//  UIViewController.swift
//  rssReader2
//
//  Created by Tony on 11/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(title: String?, message: String?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func presentAddFeedAlert(complition: @escaping ((_ path: String?) -> ())) {
        let feedAlert = UIAlertController(title: "Feed",
                                          message: "Enter feed URL",
                                          preferredStyle: .alert)
        
        feedAlert.addTextField { (textField) in
            textField.placeholder = "Feed URL"
            textField.keyboardType = .URL
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive) { _ in
            complition(nil)
        }
        feedAlert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add",
                                      style: .default) { _ in
            let path = feedAlert.textFields?.first?.text
            complition(path)
        }
        feedAlert.addAction(addAction)
        
        present(feedAlert, animated: true)
    }
}
