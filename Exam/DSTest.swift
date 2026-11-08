import Foundation
import Observation

/* MARK: Your task:

Write a function that:
1. Filters cars to only include BMWs.
2. Only includes cars manufactured from 2020 onwards.
3. Sorts the resulting cars by price, cheapest first.
4. Returns the resulting array.
 
*/

struct Car1: Identifiable {
    let id: Int
    let make: String
    let model: String
    let price: Double
    let year: Int
}

let cars = [
    Car1(id: 1, make: "BMW", model: "M3", price: 35000, year: 2022),
    Car1(id: 2, make: "Audi", model: "A4", price: 22000, year: 2020),
    Car1(id: 3, make: "BMW", model: "M5", price: 45000, year: 2023),
    Car1(id: 4, make: "Mercedes", model: "C Class", price: 28000, year: 2021),
    Car1(id: 5, make: "BMW", model: "118i", price: 18000, year: 2019)
]

func BMW(cars: [Car1]) -> [Car1] {
    cars.filter { car in
        car.make == "BMW"
    }
}

func newCars(cars: [Car1]) -> [Car1] {
    cars.filter { car in
        car.year > 2019
    }
}

func sortPrice(cars: [Car1]) -> [Car1] {
    cars.sorted { cheap, expensive in
        cheap.price < expensive.price
    }
}

func appliesAllConditions() -> [Car1] {
    sortPrice(cars: newCars(cars: BMW(cars: cars)))
}


/* MARK: Model Answer
 
 func appliesAllConditions(cars: [Car1]) -> [Car1] {
     cars
         .filter { $0.make == "BMW" && $0.year >= 2020 }
         .sorted { $0.price < $1.price }
 }
 
 */


/* MARK: Your tasks:
 
 1. Return only users who have both a name and an email.
 2. Return an array containing just their names.
 3. Find the user with ID 4.
 4. Explain the difference between if let and guard let.
 Bonus: Can you achieve tasks 1 and 2 using compactMap?
 
 */

struct User1 {
    let id: Int
    let name: String?
    let email: String?
}

let users = [
    User1(id: 1, name: "John", email: "john@gmail.com"),
    User1(id: 2, name: nil, email: "sarah@gmail.com"),
    User1(id: 3, name: "David", email: nil),
    User1(id: 4, name: "Sarah", email: "sarah@gmail.com"),
    User1(id: 5, name: nil, email: nil)
]

func nameAndEmail(users: [User1]) -> [User1] {
    users.filter { user in
        user.email != nil && user.name != nil
    }
}

func justNames(users: [User1]) -> [String] {
    nameAndEmail(users: users).compactMap { user in
        user.name
    }
}

func searchByID(users: [User1], id: Int) -> User1? {
    users.filter { user in
            user.id == id
    }.first
}


/* MARK: Model Answers
 
 func justNames(users: [User1]) -> [String] {
     nameAndEmail(users: users).compactMap(\.name)
 }
 
 func searchByID(users: [User1], id: Int) -> User1? {
     users.first { $0.id == id }
 }
 */

struct APIResponse: Decodable {
    let collection: CollectionModel
    let data: [Make]
}

struct CollectionModel: Decodable {
    let url: String
    let count: Int
    let pages: Int
    let total: Int
    let next: String?
    let prev: String?
    let first: String
    let last: String
}

struct Make: Decodable, Identifiable {
    let id: Int
    let name: String
}

protocol CarServiceProtocol {
    
    func fetch() async throws -> APIResponse
    
}


struct APIService: CarServiceProtocol {
    
    let url = "https://carapi.app/api/makes/v2"
    
    func fetch() async throws -> APIResponse {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        if response.statusCode > 299 || response.statusCode < 200 {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(APIResponse.self, from: data)
    }
}


enum ViewState {
    case loading
    case loaded
    case empty
    case error(String)
}

@Observable
class CarViewModel {
    
    private(set) var viewState: ViewState
    private(set) var makes: [Make]
    private(set) var filteredMakes: [Make]
    var searchText: String
    
    private let service: CarServiceProtocol
    
    init(service: CarServiceProtocol) {
        self.viewState = .loading
        self.makes = []
        self.filteredMakes = []
        self.searchText = ""
        self.service = service
    }
    
    func fetchMakes() async throws {
        makes = try await service.fetch().data
        viewState = .loaded
    }
    
    func search() {
        filteredMakes = makes.filter { make in
            make.name.contains(searchText)
        }
    }
    
}













