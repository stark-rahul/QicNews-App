//
//  Home.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

struct Home: View {
    
    let articlesItems: [Article]
    
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    
    @State var currentItem: Article?
    @State var showDetailPage: Bool = false
    @State var updateLike: Bool = false
    @State var updateComment: Bool = false
    @State var likesCount: Int = 0
    @State var commentsCount: Int = 0
    @State var updateBookmark: Bool = false
    
    //match Geomatry effect
    @Namespace var animation
    
    // Detail Animation property
    @State var animateView: Bool = false
    @State var animateContent: Bool = false
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(currentDate) • Today")
                            .font(.callout)
                            .foregroundStyle(.gray)
                        Text("Let's Explore QicNews")
                            .font(.title.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Button {
                        
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .opacity(showDetailPage ? 0 : 1)
                
                // FOR EACH
                ForEach(articlesItems) { item in
                    Button {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            currentItem = item
                            showDetailPage = true
                        }
                    } label: {
                        cardView(item: item)
                            .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                    }
                    .buttonStyle(ScaledButtonStyle())
                    .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
                }
            }
            .padding(.vertical)
        }
        .overlay {
            if let currentItem = currentItem, showDetailPage {
                detailView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.ultraThinMaterial)
                .frame(height: animateView ? nil : 350, alignment: .top)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
    
    //CARD VIEW
    @ViewBuilder
    func cardView(item: Article) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {
                // Banner Image
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    AsyncImage(url: item.imageURL) { phase in
                        switch phase {
                        case .empty:
                            Image("placeholder") // need to change later
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 15))
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 15))
                        case .failure(let error):
                            Image("placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 15))
                            
                        @unknown default:
                            fatalError()
                        }
                    }
                }
                .frame(height: 200)
                
                // LEANER GRADIENT
                LinearGradient(colors: [
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.authorText)
                        .lineLimit(1)
                        .font(.callout)
                        .fontWeight(.semibold)
                    Text(item.title)
                        .font(.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                .foregroundStyle(.primary)
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
            }
            
            //HSTACK VIEW CONTENT
            HStack(spacing: 12) {
                Image("Logo1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                //VSTACK DETAILS
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.descriptionText)
                        .lineLimit(1)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text(item.contentText)
                        .lineLimit(1)
                        .fontWeight(.bold)
                    
                    Text(item.captionText)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                }
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    toggleBookmark(for: item)
                } label: {
                    Image(systemName: articleBookmarkVM.isBookmarked(for: item) ? "bookmark.fill" : "bookmark")
                }
                .buttonStyle(.bordered)
            }
            .padding([.horizontal, .bottom])
        }
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    private func toggleBookmark(for article: Article) {
        if articleBookmarkVM.isBookmarked(for: article) {
            articleBookmarkVM.removeBookmark(for: article)
        } else {
            articleBookmarkVM.addBookmark(for: article)
        }
    }
    
    //DETAIL VIEW
    @ViewBuilder
    func detailView(item: Article) -> some View  {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                cardView(item: item)
                    .scaleEffect(animateView ? 1 : 0.93)
                
                VStack(alignment: .leading, spacing: 15) {
                    // Likes and comments stack
                    HStack(alignment: .bottom, spacing: 8) {
                        
//                        // likes
                        Button {
                            print("Button pressed")
                            updateLike.toggle()
                        } label: {
                            Image(systemName: updateLike ? "heart.text.square.fill" : "heart.text.square")
                            Text("Likes: \(articleNewsVM.likesCounts[item.articleId, default: 0])")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .buttonStyle(.bordered)
//                        
//                        // comments
                        Button {
                            updateComment.toggle()
                            print("Button pressed")
                        } label: {
                            Image(systemName: updateComment ? "person.crop.square.filled.and.at.rectangle" : "person.crop.square.filled.and.at.rectangle.fill")
                            Text("Comments: \(articleNewsVM.commentsCounts[item.articleId, default: 0])")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .buttonStyle(.bordered)
                    }
                    Text(item.title)
                        .font(.title.bold())
                        .multilineTextAlignment(.leading)
                        .matchedGeometryEffect(id: "bannerTitle", in: animation)
                    Divider()
                    Text(item.contentText)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset: 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing, content: {
            Button {
                //closing View
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentItem = nil
                    showDetailPage = false
                }
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.white)
                
            }
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.16)) {
                animateContent = true
            }
            // Load likes and comments when the detail page appears
            Task {
                await articleNewsVM.loadLikes(for: item.articleId)
                await articleNewsVM.loadComments(for: item.articleId)
            }
        }
        .transition(.identity)
    }
}

#Preview {
    Home(articlesItems: Article.previewData)
        .preferredColorScheme(.dark)
}


