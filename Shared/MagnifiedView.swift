import SwiftUI

struct MagnifiedView<Content: View>: View {
    
    enum MagSize: CGFloat {
        case minimize = 70, peek = 100, expand = 300
    }

    @State private var contentScale: CGFloat = 3
    @State private var magSize: MagSize = .minimize
    
    let contentSize: CGSize
    @Binding var location: CGPoint
    let content: () -> Content
    
    var contentAnchor: UnitPoint {
        UnitPoint(
            x: (location.x / contentSize.width).clamp(0, 1),
            y: (location.y / contentSize.height).clamp(0, 1)
        )
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 2).onChanged({ g in
            location = g.location
            withAnimation { magSize = .expand }
        }).onEnded({ _ in
            withAnimation { magSize = .peek }
        })
    }
    
    var magShape: some Shape {
        Circle()
            .size(width: magSize.rawValue, height: magSize.rawValue)
            .offset(location)
            .offset((-magSize.rawValue / 2).asSize)
    }
    
    var body: some View {
        content()
            .scaleEffect(contentScale, anchor: contentAnchor)
            // NOTE: Enable drawingGroup for lossless scaled rendering like text, shapes, and UI elements.
            // It will negativly effect performance on large views containing rasterized images.
            //.drawingGroup()
            .clipShape(magShape)
            .overlay(magShape.stroke(lineWidth: 5).fill(Color.black))
            .overlay(magShape.stroke(lineWidth: 2).fill(Color.white))
            .gesture(drag)
    }
}

extension Comparable {
    func clamp(_ min: Self, _ max: Self) -> Self {
        var new = self
        if self > max { new = max }
        if self < min { new = min }
        return new
    }
}

extension CGFloat {
    var asSize: CGSize {
        CGSize(width: self, height: self)
    }
}
