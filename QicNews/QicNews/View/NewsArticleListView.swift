//
//  NewsArticleListView.swift
//  QicNews
//
//  Created by Guest on 01/01/25.
//

import SwiftUI

struct NewsArticleListView: View {
    
    let articles: [Article]
    
    @Namespace var namespace
    
    var body: some View {
        ScrollView {

        }
        Text("Hello world")
    }
}

#Preview {
    NewsArticleListView(articles: Article.previewData)
}
