import SwiftUI

struct ContentView: View {
    @State var point = Identified(data: CGPoint(x: 200, y: 350))
    @State var selected = 0
    
    var body: some View {
        TabView(selection: $selected) {
            ExampleA().magnify($point)
                .tag(0)
                .tabItem {
                    Image(systemName: "a.circle\(selected == 0 ? ".fill" : "")")
                        .imageScale(.large)
                    Text("Example")
                }

            ExampleB().magnify($point)
                .tag(1)
                .tabItem {
                    Image(systemName: "b.circle\(selected == 1 ? ".fill" : "")")
                        .imageScale(.large)
                    Text("Example")
                }
        }
        .edgesIgnoringSafeArea(.top)
        .environment(\.horizontalSizeClass, .compact)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
