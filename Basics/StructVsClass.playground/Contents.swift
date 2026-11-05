import Foundation

// MARK: Class = Refrence ~ Struct = Value

struct PersonS {
    var name: String
    var age: Int
}

class PersonC {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let aaron = PersonS(name: "aaron", age: 24)
var aaronCopy = aaron

let sammy = PersonC(name: "sammy", age: 25)
let sammyCopy = sammy

aaronCopy.name = "aaron_copy"
sammyCopy.name = "sammy_copy"


print(aaron.name)   // isnt affected by name change as it creates a new copy
print(sammy.name)   // points to refrence to renames sammy class
