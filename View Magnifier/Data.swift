import SwiftUI

struct Identified<D>:Identifiable {
    let id:String = UUID().uuidString
    var data:D
}

struct Person {
    let id = UUID()
    let firstName:String
    let lastName:String
    let dateOfBirth:Date
    let image:Image
}

struct PersonFactory {
    
    static let firstNames = [
        "female": ["Rose","Amy","Jessica","Mia","Isabella","Ellie","Nadia","Velma"],
        "male": ["Max","Charles","Robert","Cole","William","Xander","Alexander","Jasper"]
    ]
    
    static let lastNames = [
        "Sandoval","Vargas","Byrne","Steele","Hoffman","Thorne","Rodgers",
        "Solis","Lawrence","Molina","Rhodes","Baldwin","Faulkner","Lang"
    ]
    
    static let ages = [
        Date(timeIntervalSinceNow: -600000000),
        Date(timeIntervalSinceNow: -800000000),
        Date(timeIntervalSinceNow: -1100000000),
        Date(timeIntervalSinceNow: -1800000000),
        Date(timeIntervalSinceNow: -2500000000),
        Date(timeIntervalSinceNow: -1000000000),
        Date(timeIntervalSinceNow: -900000000)
    ]
    
    static let imageNames = [
        "male":["p2","p4","p6","p7","p9","p10"],
        "female":["p0","p1","p3","p5","p8","p11"]
    ]
    
    static let genders = ["male", "female"]
    
    static func make(number: Int = 6) -> [Person] {
        var res:[Person] = []
        
        for _ in 0..<number {
            let gender = genders.randomElement()!
            
            guard
                let f = firstNames[gender]!.randomElement(),
                let l = lastNames.randomElement(),
                let b = ages.randomElement(),
                let i = imageNames[gender]!.randomElement()
            else { continue }
            
            res.append(Person(firstName: f, lastName: l, dateOfBirth: b, image: Image(i)))
        }

        return res
    }
}
