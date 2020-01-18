# View Magnifier

This view magnifier project enables the magnification of any SwiftUI view. Just give the modifier a binded CGPoint where you want to magnifier to start.

```
struct ContentView: View {
    @State var point = Identified(data: CGPoint(x: 200, y: 350))
    
    var body: some View {
        Image().magnify($point)
    }
}
```

![View Magnifier v1.0](read_me.gif)

## Authors
* **Eli Slade** - *Inital Work* - [Eli Slade](https://github.com/elislade)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
