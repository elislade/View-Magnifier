import SwiftUI

struct ContentView: View {
    
    @ObservedObject var media: MediaProvider
    @State private var point = CGPoint(x: 200, y: 350)
    
    var infoView: some View {
        HStack(spacing: 15){
            MediaProviderStateView(media: media).frame(width: 180)
            Spacer()
            Button(action: { open(media.currentItem.attribution.url) }){
                Text(media.currentItem.attribution.name).italic()
            }
        }
        .font(.system(.footnote, design: .monospaced))
        .padding(.horizontal).padding(.vertical, 10)
    }
    
    var xy: some View {
        HStack(spacing: 10){
            Text("X:\(Int(point.x))")
            Text("Y:\(Int(point.y))")
        }
        .font(.system(.footnote, design: .monospaced))
        .padding()
    }
    
    var body: some View {
        VStack(spacing: 0){
            infoView.zIndex(100)
            Divider().edgesIgnoringSafeArea(.all)
            Spacer(minLength: 0)
            media.currentItem.resolvedImage?
                .resizable()
                .scaledToFit()
                .magnify($point)
            Spacer(minLength: 0)
        }
        .overlay(xy, alignment: .bottomLeading)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(media: MediaProvider())
    }
}

func open(_ url: URL) {
#if os(macOS)
    NSWorkspace.shared.open(url)
#endif
#if os(iOS)
    UIApplication.shared.open(url, options: [:])
#endif
}
