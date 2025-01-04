//
//  NewsAPI.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI
import Foundation
 
struct NewsAPI {
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "YOUR_API_KEY" // Your API Key
    private var session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    // Allowing dependency injection for testing
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch(from category: Category) async throws -> [Article] {
        let url = generateNewsURL(from: category)
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponseLayer.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "An error occurred in the API response")
            }
        default:
            throw generateError(description: "A server error occurred")
        }
    }
    
    // Fetch likes for an article
    func fetchLikes(for articleId: String) async throws -> Int {
        let likesURL = URL(string: "https://cn-news-info-api.herokuapp.com/likes/\(articleId)")!
        let (data, response) = try await session.data(from: likesURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw generateError(description: "Failed to fetch likes")
        }
        
        guard let likesCount = try? jsonDecoder.decode(Int.self, from: data) else {
            throw generateError(description: "Invalid likes response format")
        }
        
        return likesCount
    }
    
    // Fetch comments for an article
    func fetchComments(for articleId: String) async throws -> Int {
        let commentsURL = URL(string: "https://cn-news-info-api.herokuapp.com/comments/\(articleId)")!
        let (data, response) = try await session.data(from: commentsURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw generateError(description: "Failed to fetch comments")
        }
        
        guard let commentsCount = try? jsonDecoder.decode(Int.self, from: data) else {
            throw generateError(description: "Invalid comments response format")
        }
        
        return commentsCount
    }
    
    // Helper: Generate API URL for news fetching
    private func generateNewsURL(from category: Category) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "country=us"
        url += "&category=\(category.rawValue)"
        url += "&apiKey=\(apiKey)"
        return URL(string: url)!
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

// MARK: - Article Extension for Fetching Likes and Comments
extension Article {
    // Asynchronous method to fetch likes
    func fetchLikes() async throws -> Int {
        try await NewsAPI.shared.fetchLikes(for: articleId)
    }
    
    // Asynchronous method to fetch comments
    func fetchComments() async throws -> Int {
        try await NewsAPI.shared.fetchComments(for: articleId)
    }
}
