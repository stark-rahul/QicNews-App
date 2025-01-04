//
//  ArticleContentCell.swift
//  QicNews
//
//  Created by Guest on 01/01/25.
//

import SwiftUI

struct NewsArticleLayerCell: View {
    
//    let article: Article
    
    @Namespace var namespace
    @State var show = false
    var body: some View {
        ZStack {
            if !show {
                NewsArticleLayerView(namespace: namespace, show: $show)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.52, dampingFraction: 0.58)) {
                            show.toggle()
                        }
                    }
            }
            
            if show {
                NewsDetailsLayerView(namespace: namespace, show: $show)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NewsArticleLayerCell()
}
