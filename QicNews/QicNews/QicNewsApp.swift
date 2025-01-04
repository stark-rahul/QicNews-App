//
//  QicNewsApp.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

@main
struct QicNewsApp: App {
    
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {

            ContentView()
                .environmentObject(articleBookmarkVM)
                .preferredColorScheme(.dark) // made default for attractive appearence.
        }
    }
}
