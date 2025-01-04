//
//  Article.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import Foundation
import SwiftUI


fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article {
    
    // This id will be unique and auto generated from client side to avoid clashing of Identifiable in a List as NewsAPI response doesn't provide unique identifier
    let id = UUID().uuidString

    let source: Source
    let title: String
    let url: String
    let content: String?
    let publishedAt: Date
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case source
        case title
        case url
        case content
        case publishedAt
        case author
        case description
        case urlToImage
    }
    
    var authorText: String {
        author ?? ""
    }
    
    var contentText: String {
        content ?? "Here unable to fetch the content from the API due to found nil value in the content."
    }
    
    var descriptionText: String {
        description ?? ""
    }
    
    var captionText: String {
        "\(source.name) ‧ \(relativeDateFormatter.localizedString(for: publishedAt, relativeTo: Date()))"
    }
    
    var articleURL: URL? {
        return URL(string: url)!
    }
    
    // MARK: - For article ID -> obtain Likes and comments
    var articleId: String {
        guard let url = URL(string: url) else { return "URL Found -- Null" }
        return url.host?.appending(url.path.replacingOccurrences(of: "/", with: "-")) ?? ""
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
}

extension Article: Codable {}
extension Article: Equatable {}
extension Article: Identifiable {}

extension Article {
    
    static var previewData: [Article] {
        let previewDataURL = Bundle.main.url(forResource: "qicnews", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataURL)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        
        let apiResponse = try! jsonDecoder.decode(NewsAPIResponseLayer.self, from: data)
        return apiResponse.articles ?? []
    }
}


struct Source {
    let name: String
}

extension Source: Codable {}
extension Source: Equatable {}
