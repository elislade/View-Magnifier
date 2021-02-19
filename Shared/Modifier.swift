import SwiftUI

struct MagnifierModifier: ViewModifier {
    @Binding var point: CGPoint
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                MagnifiedView(contentSize: proxy.size, location: _point){
                    content
                }
            }
        )
    }
}

extension View {
    func magnify(_ point: Binding<CGPoint>) -> some View {
        modifier(MagnifierModifier(point: point))
    }
}
