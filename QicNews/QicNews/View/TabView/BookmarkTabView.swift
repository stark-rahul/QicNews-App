//
//  BookmarkTabView.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    var body: some View {
        NavigationView {
            Home(articlesItems: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
//                .navigationTitle("Saved Articles")
        }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            VStack {
                EmptyPlaceholderView(text: "No saved article", image: Image(systemName: "bookmark"))
            }
            .offset(y: 280)
        }
    }
}

#Preview {
    BookmarkTabView()
}
