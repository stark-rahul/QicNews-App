////
////  NewsReplicaView.swift
////  QicNews
////
////  Created by Guest on 03/01/25.
////
//
//import Foundation
//import SwiftUI
//
//struct NewsReplicaView: View {
//    var body: some View {
//        //MARK: - Animating properties
//        @State var currentItem: Article?
//        @State var showDetailPage: Bool = false
//        @State var detailStack: Bool = false
//
//        //Matched Geometry Effect
//        @Namespace var animation
//
//        //DetailView animation property
//        @State var animateView: Bool = false
//
//        var body: some View {
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack(spacing: -90) {
//                    HStack(alignment: .top) {
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Let's have QicNews")
//                                .font(.callout)
//                                .foregroundStyle(.blue)
//                            Text("Explore")
//                                .font(.largeTitle.bold())
//                        }
//                        .padding(.bottom, 70)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        
//                        Button {
//                            
//                        } label: {
//                            Image(systemName: "newspaper.circle.fill")
//                                .font(.largeTitle)
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom)
//                    .opacity(showDetailPage ? 0 : 1)
//                    
//                    ForEach(Article.previewData) { item in
//                        Button {
//                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
//                                currentItem = item
//                                showDetailPage = true
//                            }
//                        } label: {
//                            CardView(item: item)
//                                .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
//                        }
//                        .buttonStyle(ScaledButtonStyle())
//                        .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
//                    }
//                }
//                .padding(.vertical)
//            }
//            .overlay {
//                if let currentItem = currentItem, showDetailPage {
//                    DetailView(item: currentItem)
//                        .ignoresSafeArea(.container, edges: .top)
//                }
//            }
//            .background(alignment: .top) {
//                RoundedRectangle(cornerRadius: 18, style: .continuous)
//                    .fill(.ultraThinMaterial)
//                    .frame(height: animateView ? nil : 350, alignment: .top)
//                    .opacity(animateView ? 1 : 0)
//                    .ignoresSafeArea()
//            }
//        }
//
//        //MARK: - CardView
////        @ViewBuilder
//        func CardView(item: Article) -> some View {
//            VStack(alignment: .leading, spacing: 0) {
//                ZStack (alignment: .bottomLeading) {
//                    GeometryReader { proxy in
//                        let size = proxy.size
//                        
//                        Image("news-placeholder")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: size.width, height: size.height)
//                            .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 18))
//                    }
//                    .frame(height: 250)
//                    
//                    //Logic for managing safe area parameters using offset
//                    .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
//                }
//                
//                if !detailStack {
//                    ZStack {
//                        VStack (alignment: .leading, spacing: 10) {
//                            Text("Headlines")
//                                .font(.title.weight(.semibold))
//                                .matchedGeometryEffect(id: "Headline", in: animation)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            Text("Captions")
//                                .font(.headline.weight(.light))
//                                .matchedGeometryEffect(id: "Caption", in: animation)
//                            Text("This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa ....")
//                                .font(.footnote)
//                                .matchedGeometryEffect(id: "footnote", in: animation)
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 150)
//                    .overlay(starOverlay, alignment: .topTrailing)
//                    .background(
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                    )
//                    .clipShape(CustomCorners(corners: [.bottomLeft, .bottomRight], radius: 18))
//                    .offset(y: -80)
//                    .matchedGeometryEffect(id: item.id, in: animation)
//                }
//            }
//            //        .background(
//            //            RoundedRectangle(cornerRadius: 15, style: .continuous)
//            //                .fill()
//            //        )
//        }
//
//        //MARK: - DetailView
//        func DetailView(item: Article) -> some View {
//            ScrollView(.vertical, showsIndicators: false) {
//                VStack {
//                    CardView(item: item)
//                        .scaleEffect(animateView ? 1 : 0.93)
//                    
//                    VStack(alignment: .leading, spacing: 12) {
//                        Text("This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa ... /n This is today hot news about elon mask This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa .... This is today hot news about elon mask space x program going to launch the crew pad at the femiler station of florida with the help of nasa ....")
//                            .font(.footnote)
//                        //                    .matchedGeometryEffect(id: "footnote", in: namespace)
//                        Text("Captions")
//                            .font(.headline.weight(.light))
//                        //                    .matchedGeometryEffect(id: "Caption", in: namespace)
//                        Divider()
//                        Text("Headlines program going to launch the crew pad at the femiler station program going to launch the crew pad at the femiler station program")
//                            .font(.title.weight(.semibold))
//                        //                    .matchedGeometryEffect(id: "Headline", in: namespace)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                    }
//                    .padding(20)
//                    .overlay(starOverlay, alignment: .topTrailing)
//                    .background(
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                            .mask(RoundedRectangle(cornerRadius: 18.4, style: .continuous))
//                        //                        .matchedGeometryEffect(id: "blur", in: namespace)
//                    )
//                    
//                }
//                .offset(y: -20)
//            }
//            
//            .overlay(alignment: .topTrailing, content: {
//                Button {
//                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
//                        animateView = false
//                        detailStack = false
//                    }
//                    
//                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
//                        currentItem = nil
//                        showDetailPage = false
//                    }
//                } label: {
//                    Image(systemName: "xmark.circle.fill")
//                        .font(.title)
//                        .foregroundStyle(.clear)
//                        .background(
//                            .ultraThinMaterial, in: Circle()
//                        )
//                }
//                .padding()
//                .padding(.top, safeArea().top)
//                .offset(y: -10)
//                .opacity(animateView ? 1 : 0)
//            })
//            .onAppear {
//                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
//                    animateView = true
//                    detailStack = true
//                }
//            }
//            .transition(.identity) // For transition
//        }
//        }
//
//
//        private var starOverlay: some View {
//        ZStack {
//            UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10, bottomTrailing: 10))
//                .fill(Color.gray.opacity(0.5))
//                .background(
//                    .ultraThinMaterial
//                )
//                .frame(width: 20, height: 30)
//                .padding([.vertical, .trailing], 10)
//            
//            // Star image
//            Image(systemName: "star.fill")
//                .foregroundColor(.yellow)
//                .padding([.top, .trailing], 10)
//        }
//    }
//}
//
//#Preview {
//    NewsReplicaView()
//}
