//
//  NewsAPITests.swift
//  QicNews
//
//  Created by Guest on 05/01/25.
//

import XCTest
@testable import QicNews

final class NewsAPITests: XCTestCase {
    
    var newsAPI: NewsAPI!

    override func setUp() {
        super.setUp()
        let mockSession = URLSession.mockSession()
        newsAPI = NewsAPI(session: mockSession)
    }

    override func tearDown() {
        newsAPI = nil
        super.tearDown()
    }

    func testFetchArticlesSuccess() async throws {
        // Mock response data
        let mockResponse = """
        {
            "status": "ok",
            "articles": [
                {
                    "title": "Sample Article",
                    "description": "This is a sample article",
                    "urlToImage": "https://example.com/image.png",
                    "content": "This is content",
                    "publishedAt": "2025-01-04T12:34:56Z",
                    "author": "Author Name",
                    "url": "https://example.com",
                    "source": { "name": "Source Name" }
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Mock HTTP response
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=0d064a5f48e942e698f601f1307c0d12")!
        MockURLProtocol.mockResponses[url] = (
            data: mockResponse,
            response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        let articles = try await newsAPI.fetch(from: .general)
        
        XCTAssertEqual(articles.count, 1)
        XCTAssertEqual(articles.first?.title, "Sample Article")
    }

    func testFetchArticlesError() async throws {
        // Mock an error response
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=0d064a5f48e942e698f601f1307c0d12")!
        MockURLProtocol.mockResponses[url] = (
            data: nil,
            response: HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        do {
            _ = try await newsAPI.fetch(from: .general)
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertEqual((error as NSError).localizedDescription, "A server error occurred")
        }
    }

    func testFetchLikesSuccess() async throws {
        // Mock response data
        let mockLikes = 42
        let mockResponse = "\(mockLikes)".data(using: .utf8)!
        let url = URL(string: "https://cn-news-info-api.herokuapp.com/likes/article123")!
        
        MockURLProtocol.mockResponses[url] = (
            data: mockResponse,
            response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        let likes = try await newsAPI.fetchLikes(for: "article123")
        
        XCTAssertEqual(likes, mockLikes)
    }

    func testFetchLikesError() async throws {
        // Mock an error response
        let url = URL(string: "https://cn-news-info-api.herokuapp.com/likes/article123")!
        MockURLProtocol.mockResponses[url] = (
            data: nil,
            response: HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        do {
            _ = try await newsAPI.fetchLikes(for: "article123")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertEqual((error as NSError).localizedDescription, "Failed to fetch likes")
        }
    }

    func testFetchCommentsSuccess() async throws {
        // Mock response data
        let mockComments = 10
        let mockResponse = "\(mockComments)".data(using: .utf8)!
        let url = URL(string: "https://cn-news-info-api.herokuapp.com/comments/article123")!
        
        MockURLProtocol.mockResponses[url] = (
            data: mockResponse,
            response: HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        let comments = try await newsAPI.fetchComments(for: "article123")
        
        XCTAssertEqual(comments, mockComments)
    }

    func testFetchCommentsError() async throws {
        // Mock an error response
        let url = URL(string: "https://cn-news-info-api.herokuapp.com/comments/article123")!
        MockURLProtocol.mockResponses[url] = (
            data: nil,
            response: HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        do {
            _ = try await newsAPI.fetchComments(for: "article123")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertEqual((error as NSError).localizedDescription, "Failed to fetch comments")
        }
    }
}
