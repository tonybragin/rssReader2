//
//  ViewController.swift
//  rssReader2
//
//  Created by Tony on 10/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit
import Kingfisher

protocol FeedDataItemProtocol {
    var source: String? { get }
    var imagePath: String? { get }
    var title: String? { get }
    var description: String? { get }
    var publicationDay: Date? { get }
}

protocol FeedViewControllerProtocol: UIViewController {
    var tableView: UITableView! { get set }
    var presenter: FeedPresenterProtocol? { get set }
    var feedData: [FeedDataItemProtocol] { get set }
}

class FeedViewController: UIViewController, FeedViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FeedPresenterProtocol?
    var feedData: [FeedDataItemProtocol] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.viewDidLoad()
    }


    @IBAction func addButtonTouched(_ sender: UIBarButtonItem) {
        presenter?.addButtonTouched()
    }
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        
        if let imageString = feedData[indexPath.row].imagePath,
            let imageURL = URL(string: imageString) {
            cell.sourceImageView.kf.setImage(with: imageURL)
        }
        
        cell.sourceLabel.text = feedData[indexPath.row].source
        cell.titleLabel.text = feedData[indexPath.row].title
        
        return cell
    }
    
    
}

extension FeedViewController: UITableViewDelegate {
    
}

extension FeedDataItem: FeedDataItemProtocol {}
