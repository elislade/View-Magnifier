import SwiftUI
import Combine

struct Magnified {
    typealias ViewData = Identified<CGPoint>
    
    static let Space = "MagnifiedSpace_\(UUID().uuidString)"
    
    enum Size:CGFloat {
        case minimize = 50, peek = 200, expand = 300
        
        var cgSize:CGSize {
            CGSize(
                width: self.rawValue,
                height: self.rawValue
            )
        }
    }
    
    struct Pubs {
        static let didFinishDraging = PassthroughSubject<ViewData, Never>()
    }
}

struct MagnifiedView<Content>: View where Content: View {
    
    //MARK: Constants
    let minScale:CGFloat = 2
    let maxScale:CGFloat = 8
    
    //MARK: Private Properties
    @State private var scale:CGFloat = 3
    @State private var scaleDelta:CGFloat = 1
    @State private var magSize:Magnified.Size = .minimize
    
    //MARK: Public Properties
    @State var size:CGSize
    @State var location:Magnified.ViewData
    
    var content:Content
    
    var body: some View {
        
        func contentAnchor() -> UnitPoint {
            UnitPoint(
                x: (location.data.x / size.width).clamp(0, 1),
                y: (location.data.y / size.height).clamp(0, 1)
            )
        }
        
        func contentOffset() -> CGSize {
            CGSize(
                width: (size.width / 2) - location.data.x,
                height: (size.height / 2) - location.data.y
            )
        }
        
        func contentScale() -> CGFloat {
            (scale * scaleDelta).clamp(minScale, maxScale)
        }
        
        let drag = DragGesture(minimumDistance:2, coordinateSpace: .named(Magnified.Space)).onChanged({ g in
            self.location.data = g.location
            withAnimation {
                self.magSize = .expand
            }
        }).onEnded({ _ in
            Magnified.Pubs.didFinishDraging.send(self.location)
            withAnimation {
                self.magSize = .peek
            }
        })
        
        let pinch = MagnificationGesture().onChanged({ scale in
            self.scaleDelta = scale
            withAnimation {
                self.magSize = .expand
            }
        }).onEnded({ _ in
            self.scale *= self.scaleDelta
            self.scaleDelta = 1
        })
        
        return Group {
            content
                .frame(width: size.width, height: size.height)
                .scaleEffect(contentScale(), anchor: contentAnchor())
                .offset(contentOffset())
                .allowsHitTesting(false)
        }
        .frame(width: magSize.rawValue, height: magSize.rawValue)
        .overlay(Image("mag-foreground").resizable())
        .cornerRadius(magSize.rawValue / 2)
        .offset(x: location.data.x, y: location.data.y)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 6)
        .gesture(drag)
        .gesture(pinch)
        .onTapGesture {
            withAnimation {
                if self.magSize == .expand {
                    self.magSize = .minimize
                    self.scaleDelta = 0.2
                } else {
                    self.magSize = .expand
                    self.scaleDelta = 1
                }
            }
        }
    }
}

struct MagnifierModifier: ViewModifier {
    @Binding var point: Identified<CGPoint>
    
    func body(content: Content) -> some View {
        content.overlay(
            GeometryReader { proxy in
                Group {
                    ForEach(0..<1) { _ in 
                        MagnifiedView(
                            size: proxy.size,
                            location: self.point,
                            content: content
                        ).frame(width:1, height:1)
                    }
                }.coordinateSpace(name: Magnified.Space)
            }
        )
    }
}

extension View {
    func magnify(_ point: Binding<Identified<CGPoint>>) -> some View {
        self.modifier(MagnifierModifier(point: point))
    }
}
