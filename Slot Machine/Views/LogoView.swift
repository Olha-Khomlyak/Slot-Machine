import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .frame(minWidth:256, idealWidth: 300, maxWidth: 320, minHeight: 110, idealHeight: 125, maxHeight: 135,alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
    }
}

#Preview {
    LogoView()
}
