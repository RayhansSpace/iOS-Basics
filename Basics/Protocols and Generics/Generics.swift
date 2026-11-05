import Foundation


struct Garage<T: Vehicle> {
    
    func canFit(_ vehicle: T) -> Bool {
        switch vehicle {
        case is Car: return true
        case is Bicycle: return true
        default: return false
        }
    }
}
