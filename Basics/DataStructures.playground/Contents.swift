import Foundation

// MARK: Array
var subjects: [String] = ["Maths","English","French"]
subjects.append("Art")
subjects += ["Computer Science","German"]

let shortSubjects = subjects.filter {$0.count < 6}
let subjectLength = subjects.map { $0.count }

// MARK: Set

var fruits: Set<String> = ["Apple", "Banana", "Pear"]
var fruitsInSeason: Set<String> = ["Apple", "Lychee"]
var veg: Set<String> = ["Carrot", "Pepper"]

fruits.insert("Apple") // does nothing
fruits.insert("Orange")
fruits.remove("Pear")

fruits.intersection(fruitsInSeason)
let healthyFood = fruits.union(veg)
let fruitsOutOfSeason = fruits.subtracting(fruitsInSeason)
let difference = fruits.symmetricDifference(fruitsInSeason)

// MARK: Dictionaries

var friends = Dictionary<String, Int>()
friends["Rob"] = 22
friends["Anna"] = 24
friends["Max"] = 23

print(friends["Anna"] ?? "no friend called Anna")
friends.removeValue(forKey: "Rob")

for (name, age) in friends {
    print("\(name) is \(age) years old")
}

friends.count
friends.isEmpty
friends.keys
friends.values
friends.first
friends.first?.key
friends.first?.value
