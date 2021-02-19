import SwiftUI
import Combine

class MediaProvider: ObservableObject {
    
    let timer = Timer.publish(every: 20, on: .current, in: .default)
    
    private(set) var items: [Item]

    var currentItemIndex: Int = 0 {
        willSet {
            resolveItem(nextItemIndex)
        }
        didSet {
            startTimer()
            animateProgress()
        }
    }
    
    @Published var progress: Double = 0
    
    var currentItem: Item {
        items[currentItemIndex]
    }
    
    var nextItemIndex: Int {
        currentItemIndex == (items.count - 1) ? 0 : currentItemIndex + 1
    }
    
    private var watch: Set<AnyCancellable> = []
    
    init() {
        items = [
            Item("https://i.imgur.com/pPj2540.jpg", ("Oliver Bonhomme", "http://www.olivierbonhomme.com")),
            Item( "https://pro2-bar-s3-cdn-cf6.myportfolio.com/a627b0f79823b97a2dc9b7da172899b1/709761dd-884e-46df-9a31-fc44411a6c58_rw_1920.jpg", ("Mattias Adolfsson", "https://mattiasadolfsson.com")),
            Item("https://i.4pcdn.org/x/1552339752261.jpg", ("Marco Melgrati", "https://www.icanvas.com/canvas-art-prints/artist/marco-melgrati?product=canvas&sort=popular")),
            Item("https://dw3i9sxi97owk.cloudfront.net/uploads/portfolioItems/123d0fe6c92b12868fb0c5cb22800cb5.jpg", ("Shiku Wangombe", "https://www.shikuwangombe.com")),
            Item("https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/73d9d934815475.56deeb877cdf0.jpg", ("Saki Kurobe", "https://www.behance.net/kurobe")),
        ]
        
        //currentItemIndex = 0
        //startTimer()
        resolveItem(0)
    }
    
    private func animateProgress() {
        progress = 0
        withAnimation(.linear(duration: timer.interval)) {
            progress = 1
        }
    }
    
    func startTimer() {
        watch.removeAll()
        timer.connect().store(in: &watch)
        timer.sink{ _ in
            self.currentItemIndex = self.nextItemIndex
        }.store(in: &watch)
    }
    
    func resolveItem(_ index: Int) {
        if items[index].resolved == nil {
            items[index].resolve()
        }
    }
}

extension MediaProvider {
    struct Item {
        let url: URL
        let attribution: (name: String, url: URL)
            
        var resolved: Data?
        var resolvedImage: Image? {
            guard let data = resolved else { return nil }
            
            #if os(macOS)
            return Image(nsImage: NSImage(data: data)!)
            #elseif os(iOS)
            return Image(uiImage: UIImage(data: data)!)
            #else
            return nil
            #endif
        }
        
        init(_ url: String, _ attr: (String, String)) {
            self.url = URL(string: url)!
            self.attribution = (attr.0, URL(string: attr.1)!)
        }
        
        mutating func resolve() {
            resolved = try? Data(contentsOf: url)
        }
    }
}
