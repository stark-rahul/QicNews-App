//
//  NewsDetailsLayerView.swift
//  QicNews
//
//  Created by Guest on 01/01/25.
//

import SwiftUI

struct NewsDetailsLayerView: View {
    
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                detailsCover
            }
//            .backgroundStyle(.linearGradient(colors: [.black, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
            .background(
                LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
            )
            
            Button {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.6)) {
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .ignoresSafeArea()
        }
    }
    
    var detailsCover: some View {
        
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .padding(20)
            .foregroundStyle(.black)
            .background(
                Image("news-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background", in: namespace)
            )
            .mask(
                RoundedRectangle(cornerRadius: 18.4, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
            )
            .overlay (
                VStack(alignment: .leading, spacing: 12) {
                    Text("This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa ... /n This is today hot news about elon mask This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa .... This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa ....")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "footnote", in: namespace)
                    Text("Captions")
                        .font(.headline.weight(.light))
                        .matchedGeometryEffect(id: "Caption", in: namespace)
                    Divider()
                    Text("Headlines program going to launch the crew pad at the femiler station program going to launch the crew pad at the femiler station program")
                        .font(.title.weight(.semibold))
                        .matchedGeometryEffect(id: "Headline", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 18.4, style: .continuous))
                            .matchedGeometryEffect(id: "blur", in: namespace)
                    )
                    .overlay(starOverlay, alignment: .topTrailing)
                    .offset(y: 400)
            )
//            .padding(20)
        }
}

private var starOverlay: some View {
    return ZStack {
        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10, bottomTrailing: 10))
            .fill(.ultraThinMaterial)
            .frame(width: 20, height: 30)
            .padding([.vertical, .trailing], 0)
        
        // Star image
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
            .padding([.top, .trailing], 0)
    }
}

//#Preview {
//    @Namespace var namespace: Namespace.ID
//    NewsDetailsLayerView(namespace:  i, show: .constant(true))
//}
struct NewsDetailsLayerView_preview: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        NewsDetailsLayerView(namespace: namespace, show: .constant(true))
    }
}
