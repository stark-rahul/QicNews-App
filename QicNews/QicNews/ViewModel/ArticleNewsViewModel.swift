//
//  ArticleNewsViewModel.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
}

@MainActor
class ArticleNewsViewModel: ObservableObject {
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory: Category
    @Published var likesCounts: [String: Int] = [:]
    @Published var commentsCounts: [String: Int] = [:]
    
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    // Fetch articles
    func loadArticles() async {
        if Task.isCancelled { return }
        phase = .empty
        do {
            let articles = try await newsAPI.fetch(from: selectedCategory)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            print("Error loading articles: \(error.localizedDescription)")
            phase = .failure(error)
        }
    }
    
    // Fetch likes for a specific article
    func loadLikes(for articleId: String) async {
        if Task.isCancelled { return }
        do {
            let likes = try await newsAPI.fetchLikes(for: articleId)
            if Task.isCancelled { return }
            likesCounts[articleId] = likes
        } catch {
            print("Error fetching likes for \(articleId): \(error.localizedDescription)")
            likesCounts[articleId] = 0
        }
    }
    
    // Fetch comments for a specific article
    func loadComments(for articleId: String) async {
        if Task.isCancelled { return }
        do {
            let comments = try await newsAPI.fetchComments(for: articleId)
            if Task.isCancelled { return }
            commentsCounts[articleId] = comments
        } catch {
            print("Error fetching comments for \(articleId): \(error.localizedDescription)")
            commentsCounts[articleId] = 0
        }
    }
}
