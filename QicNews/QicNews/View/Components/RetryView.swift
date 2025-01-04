//
//  RetryView.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("..Try again !!!..")
            }
        }
    }
}

#Preview {
    RetryView(text: "an error in the retry view") {
        Text("RetryButton")
    }
}
