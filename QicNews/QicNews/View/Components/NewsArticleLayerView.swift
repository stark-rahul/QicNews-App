//
//  NewsArticleLayerView.swift
//  QicNews
//
//  Created by Guest on 01/01/25.
//

import SwiftUI

struct NewsArticleLayerView: View {
    
//    let article: Article
    
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 12) {
                    Text("Headlines")
                        .font(.title.weight(.semibold))
                        .matchedGeometryEffect(id: "Headline", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Captions")
                        .font(.headline.weight(.light))
                        .matchedGeometryEffect(id: "Caption", in: namespace)
                    Text("This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa ....")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "footnote", in: namespace)
                }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(Color.blue.opacity(0.5))
                                .background(
                                    .ultraThinMaterial
                                )
                        .mask(RoundedRectangle(cornerRadius: 18.4, style: .continuous))
                        .blur(radius: 30)
                        .matchedGeometryEffect(id: "blur", in: namespace)
                )
            }
            .foregroundStyle(.white)
            .background(
                AsyncImage(url: URL(string: "https://cdn.vox-cdn.com/thumbor/7F_fPNt4RPcVyi-RPF6ww3eAHOg=/11x40:1335x688/1200x628/filters:focal(679x321:680x322)/cdn.vox-cdn.com/uploads/chorus_asset/file/25770219/Threads_search_update.png")) { imagePhase in
                    switch imagePhase {
                    case .empty:
                        ProgressView()
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: "background", in: namespace)
                    case .failure:
                        Image("news-placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: "background", in: namespace)
                    @unknown default:
                        fatalError()
                    }
                }
            )
            .mask(
                RoundedRectangle(cornerRadius: 18.4, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
            )
            .frame(height: 220)
            .padding(10)
            
            VStack {
                Spacer()
            }
        }
        .overlay(starOverlay, alignment: .topTrailing)
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

//#Preview {
//    NewsArticleLayerView()
//}
struct NewsArticleLayerView_preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NewsArticleLayerView(namespace: namespace, show: .constant(true))
    }
}
