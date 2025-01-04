//
//  ContentView.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

//import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
        }
    }
}

#Preview {
    ContentView()
}

