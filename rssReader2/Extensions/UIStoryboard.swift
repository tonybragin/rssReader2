//
//  UIStoryboard.swift
//  rssReader2
//
//  Created by Tony on 11/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func makeViewController<T: UIViewController>(storyboardName: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}

