import SwiftUI

struct ExampleA: View {
    static let people = PersonFactory.make()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Self.people.sorted(by: { $0.lastName < $1.lastName }), id: \.id){ person in
                    HStack(spacing: 13) {
                        person.image.resizable()
                            .frame(width: 50, height: 50)
                            .background(Color.accentColor)
                            .cornerRadius(34)
                        VStack(alignment: .leading, spacing: 0) {
                            Text(person.firstName).font(.title).fontWeight(.semibold)
                            Text(person.lastName).foregroundColor(.gray)
                        }
                        Spacer()
                        Text(person.dateOfBirth.toAge())
                    }.padding(.vertical, 8)
                }
            }.navigationBarTitle("People")
        }
    }
}

struct LevelTwo_Previews: PreviewProvider {
    static var previews: some View {
        ExampleA()
    }
}
