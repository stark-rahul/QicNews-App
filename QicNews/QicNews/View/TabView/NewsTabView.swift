//
//  NewsTabView.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        Home(articlesItems: articles)
            .overlay(overlayView)
            .task(id: articleNewsVM.selectedCategory, loadTask)
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                //            Refresh the news API
//                loadTask()
            }
            
        default:
            EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else  {
            return []
        }
    }
    
    private func loadTask() async {
        await articleNewsVM.loadArticles()
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.selectedCategory) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
                .imageScale(.large)
        }
    }
}

#Preview {
    NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
}
