//
//  Extension+View.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import Foundation
import SwiftUI

extension View {
    func safeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
    
    //MARK: - Scrollview Offset
    func offset(offset: Binding<CGFloat>) -> some View {
        return self
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    offset.wrappedValue = value
                }
            }
    }
    
    // Computed property to format the date
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d MMM" // Format: "Sun 5 Jan"
        return formatter.string(from: Date())
    }
}

//MARK: - Offset key
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
