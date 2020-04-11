//
//  FeedLoader.swift
//  rssReader2
//
//  Created by Tony on 10/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import FeedKit

enum RSSErrors: Error {
    case feedError
    case parserError(error: ParserError)
    case URLError
    
    var description: String {
        switch self {
        case .feedError: return "No rss feed found"
        case .parserError(let error): return error.errorDescription ?? ""
        case .URLError: return "URL error"
        }
    }
}

protocol FeedLoaderProtocol {
    
    typealias FeedLoaderComplition = ((_ result: Result<[FeedDataItem], RSSErrors>) -> ())
    
    func getItems(for path: String, complition: @escaping FeedLoaderComplition)
}

class FeedLoader: FeedLoaderProtocol {
    func getItems(for path: String, complition: @escaping FeedLoaderComplition) {
        guard let feedURL = URL(string: path) else {
            complition(.failure(.URLError))
            return
        }
        
        let parser = FeedParser(URL: feedURL)
        parser.parseAsync { (result) in
            switch result {
            case .success(let feed):
                if let rssFeed = feed.rssFeed,
                    let feedItems = rssFeed.items {
                    
                    let source = rssFeed.title
                    let imagePath = rssFeed.image?.url
                    
                    var feedData: [FeedDataItem] = []
                    for item in feedItems {
                        feedData.append(FeedDataItem(source: source,
                                                     imagePath: imagePath,
                                                     title: item.title,
                                                     description: item.description,
                                                     publicationDay: item.pubDate))
                    }
                    complition(.success(feedData))
                } else {
                    complition(.failure(.feedError))
                }
            case .failure(let error): complition(.failure(.parserError(error: error)))
            }
        }
    }
}

struct FeedDataItem {
    var source: String?
    var imagePath: String?
    var title: String?
    var description: String?
    var publicationDay: Date?
}
