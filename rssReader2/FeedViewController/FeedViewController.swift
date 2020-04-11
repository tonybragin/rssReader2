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

extension FeedDataItem: FeedDataItemProtocol {}

protocol FeedViewControllerProtocol: UIViewController {
    var tableView: UITableView! { get set }
    var presenter: FeedPresenterProtocol? { get set }
    var feedData: [FeedDataItemProtocol] { get set }
    
    func startLoading()
    func endLoading()
}

class FeedViewController: UIViewController, FeedViewControllerProtocol {
    
    // MARK: - Constants
    
    private let selectedCellHeight: CGFloat = 350
    private let unselectedCellHeight: CGFloat = 120
    
    // MARK: - Properties
    
    var presenter: FeedPresenterProtocol?
    var feedData: [FeedDataItemProtocol] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    private var selectedCellIndexPath: IndexPath?
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        endLoading()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Public
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.isHidden = false
            self?.activityIndicator.startAnimating()
        }
        
    }
    
    func endLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.isHidden = true
        }
        
    }

    // MARK: - IBActions
    
    @IBAction func addButtonTouched(_ sender: UIBarButtonItem) {
        presenter?.addButtonTouched()
    }
}

// MARK: - Working with UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
            return selectedCellHeight
        }
        return unselectedCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell") as! FeedTableViewCell
        cell.configure(for: feedData[indexPath.row])
        return cell
    }
}

// MARK: - Working with UITableViewDelegate

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            selectedCellIndexPath = indexPath
        }

        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
