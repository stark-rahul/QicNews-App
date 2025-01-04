//
//  SwiftUIView.swift
//  QicNews
//
//  Created by Guest on 04/01/25.
//

import SwiftUI

struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
