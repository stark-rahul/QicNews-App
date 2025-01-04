//
//  EmptyPlaceholderView.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

struct EmptyPlaceholderView: View {
    
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

#Preview {
    EmptyPlaceholderView(text: "No Bookmarks", image: Image(systemName: "bookmark"))                                                                                
}
