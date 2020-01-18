import UIKit

extension CGFloat {
    func clamp(_ min:CGFloat, _ max:CGFloat) -> CGFloat {
        var new = self
        if self > max { new = max }
        if self < min { new = min }
        return new
    }
}

extension Date {
    func toAge() -> String {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: Date())

        let components = calendar.dateComponents([.year], from: date1, to: date2)
        return "\(components.year!) years old"
    }
}
