import Foundation

struct ApiService {
    
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


//struct APIResponse: Decodable {
//    let collection: CollectionModel
//    let data: [DataModel]
//}

//struct CollectionModel: Decodable {
//    let url: String
//    let count: Int
//    let pages: Int
//    let total: Int
//    let next: String?
//    let prev: String?
//    let first: String
//    let last: String
//}
//
//struct DataModel: Decodable, Identifiable {
//    let id: Int
//    let name: String
//}
