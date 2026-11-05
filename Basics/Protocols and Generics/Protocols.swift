import Foundation

protocol Vehicle {
    var topSpeed: Int { get }
    var numberOfWheels: Int { get }
    var isEvnvironmentallyFriendly: Bool { get }
    
    func cachow()
}

struct Car: Vehicle {
    let topSpeed: Int
    let numberOfWheels = 4
    let isEvnvironmentallyFriendly: Bool
    
    func cachow() {
        print("Vroom vroom")
    }
}

struct Bicycle: Vehicle {
    let topSpeed: Int
    let numberOfWheels = 2
    let isEvnvironmentallyFriendly = true
    
    func cachow() {
        print("Pedal pedal")
    }
}

struct Plane: Vehicle {
    let topSpeed: Int
    let numberOfWheels: Int
    let isEvnvironmentallyFriendly: Bool
    
    func cachow() {
        print("Zoom zoom")
    }

}
