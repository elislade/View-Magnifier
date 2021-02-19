import SwiftUI

struct MediaProviderStateView: View {
    
    @ObservedObject var media: MediaProvider
    
    func capWidth(_ i: Int) -> CGFloat {
        if i < media.currentItemIndex {
            return 300
        } else if i > media.currentItemIndex {
            return 0
        } else {
            return max(CGFloat(media.progress) * 300, 6)
        }
    }
    
    var shape: some InsettableShape { Capsule() }
    
    var body: some View {
        HStack(spacing: 4){
            ForEach(media.items.indices){ i in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)){
                    shape.fill().opacity(0.8).frame(maxWidth: capWidth(i))
                    shape.opacity(0.2)
                }
            }
        }
        .frame(height: 6)
        .buttonStyle(PlainButtonStyle())
        .onAppear{ media.currentItemIndex = 0 }
    }
}

struct MediaProviderStateView_Previews: PreviewProvider {
    static var previews: some View {
        MediaProviderStateView(media: MediaProvider())
    }
}
