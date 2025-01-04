//
//  NewsArticleRowView.swift
//  QicNews
//
//  Created by Guest on 02/01/25.
//

import SwiftUI

struct NewsArticleRowView: View {
    // MARK: - Animating properties
    let article: Article
    @State private var currentItem: Article?
    @State private var showDetailPage: Bool = false
    @State private var detailStack: Bool = false
    
    // Matched Geometry Effect
    @Namespace private var animation
    
    // DetailView animation property
    @State private var animateView: Bool = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: -90) {
                HeaderView(showDetailPage: $showDetailPage)
                
                ForEach(Article.previewData) { item in
                    ArticleButtonView(
                        item: item,
                        currentItem: $currentItem,
                        showDetailPage: $showDetailPage,
                        animation: animation
                    )
                }
            }
            .padding(.vertical)
        }
        .overlay {
            if let currentItem = currentItem, showDetailPage {
                DetailView(
                    item: currentItem,
                    animateView: $animateView,
                    detailStack: $detailStack,
                    currentItem: $currentItem,
                    showDetailPage: $showDetailPage,
                    animation: animation
                )
                .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(.ultraThinMaterial)
                .frame(height: animateView ? nil : 350, alignment: .top)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
}

struct HeaderView: View {
    @Binding var showDetailPage: Bool

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Let's have QicNews")
                    .font(.callout)
                    .foregroundStyle(.blue)
                Text("Explore")
                    .font(.largeTitle.bold())
            }
            .padding(.bottom, 70)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                // Action for the button
            } label: {
                Image(systemName: "newspaper.circle.fill")
                    .font(.largeTitle)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .opacity(showDetailPage ? 0 : 1)
    }
}

struct ArticleButtonView: View {
    let item: Article
    @Binding var currentItem: Article?
    @Binding var showDetailPage: Bool
    var animation: Namespace.ID

    var body: some View {
        Button {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                currentItem = item
                showDetailPage = true
            }
        } label: {
            CardView(item: item, currentItem: currentItem, showDetailPage: showDetailPage, animation: animation)
                .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
        }
        .buttonStyle(ScaledButtonStyle())
        .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
    }
}

struct CardView: View {
    let item: Article
    var currentItem: Article?
    var showDetailPage: Bool
    var animation: Namespace.ID

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CardImageView(item: item, currentItem: currentItem, showDetailPage: showDetailPage)
            if !showDetailPage {
                CardTextView(item: item, animation: animation)
            }
        }
    }
}

struct CardImageView: View {
    let item: Article
    var currentItem: Article?
    var showDetailPage: Bool

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { proxy in
                let size = proxy.size
                
                Image("news-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 18))
            }
            .frame(height: 250)
            .offset(y: currentItem?.id == item.id && showDetailPage ? safeArea().top : 0)
        }
    }
}

struct CardTextView: View {
    let item: Article
    var animation: Namespace.ID

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.title)
                    .font(.headline)
                    .lineLimit(2)
                    .matchedGeometryEffect(id: "Headline", in: animation)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(item.descriptionText)
                    .font(.subheadline)
                    .lineLimit(3)
                    .matchedGeometryEffect(id: "Caption", in: animation)
                HStack {
                    Text(item.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    Spacer()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .overlay(starOverlay, alignment: .topTrailing)
        .background(Rectangle().fill(.ultraThinMaterial))
        .clipShape(CustomCorners(corners: [.bottomLeft, .bottomRight], radius: 18))
        .offset(y: -80)
        .matchedGeometryEffect(id: item.id, in: animation)
    }
}

struct DetailView: View {
    let item: Article
    @Binding var animateView: Bool
    @Binding var detailStack: Bool
    @Binding var currentItem: Article?
    @Binding var showDetailPage: Bool
    var animation: Namespace.ID

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item, currentItem: currentItem, showDetailPage: showDetailPage, animation: animation)
                    .scaleEffect(animateView ? 1 : 0.93)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("This is today hot news about Elon Musk's SpaceX program going to launch the crew pad at the familiar station of Florida with the help of NASA ....")
                        .font(.footnote)
                    Text("Captions")
                        .font(.headline.weight(.light))
                    Divider()
                    Text("Headlines program going to launch the crew pad at the familiar station program going to launch the crew pad at the familiar station program")
                        .font(.title.weight(.semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(20)
                .overlay(starOverlay, alignment: .topTrailing)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 18.4, style: .continuous))
                )
            }
            .offset(y: -20)
        }
        .overlay(alignment: .topTrailing) {
            CloseButtonView(
                animateView: $animateView,
                detailStack: $detailStack,
                currentItem: $currentItem,
                showDetailPage: $showDetailPage
            )
        }
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
                detailStack = true
            }
        }
        .transition(.identity)
    }
}

struct CloseButtonView: View {
    @Binding var animateView: Bool
    @Binding var detailStack: Bool
    @Binding var currentItem: Article?
    @Binding var showDetailPage: Bool

    var body: some View {
        Button(action: closeDetailView) {
            Image(systemName: "xmark.circle.fill")
                .font(.title)
                .foregroundColor(.gray)
        }
        .padding()
    }

    private func closeDetailView() {
        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
            animateView = false
            detailStack = false
            currentItem = nil
            showDetailPage = false
        }
    }
}


private var starOverlay: some View {
    ZStack {
        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10, bottomTrailing: 10))
            .fill(Color.gray.opacity(0.5))
            .background(
                .ultraThinMaterial
            )
            .frame(width: 20, height: 30)
            .padding([.vertical, .trailing], 10)
        
        // Star image
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
            .padding([.top, .trailing], 10)
    }
}

#Preview {
    NewsArticleRowView(article: Article.previewData[0])
}
