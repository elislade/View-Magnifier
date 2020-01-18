import SwiftUI

struct ExampleB: View {
    var body: some View {
        Image("cabie").resizable().scaledToFit()
    }
}

struct ExampleB_Previews: PreviewProvider {
    static var previews: some View {
        ExampleB()
    }
}
