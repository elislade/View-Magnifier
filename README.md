# View Magnifier

This view magnifier project enables the magnification of any SwiftUI view. Just give the modifier a binded CGPoint where you want to magnifier to start.

```
struct ContentView: View {
    @State private var point = CGPoint(x: 200, y: 350)
    
    var body: some View {
        Image("example").magnify($point)
    }
}
```

## Authors
* **Eli Slade** - *Initial Work* - [Eli Slade](https://github.com/elislade)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
