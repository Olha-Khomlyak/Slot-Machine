//
//  Modifiers.swift
//  Slot Machine
//
//  Created by A. Faruk Acar on 26.11.2023.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorBlack"), radius: 0, x: 0, y: 6)
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .accentColor(.white)
    }
}

struct ScoreNumberModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorBlack"), radius: 0, x:0, y:3)
            .layoutPriority(1)
    }
}

struct ScoreContainerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal,16)
            .padding(.vertical,4)
            .frame(minWidth: 128)
            .background(
                Capsule()
                    .foregroundColor(Color("ColorBlack"))
            )
    }
}
