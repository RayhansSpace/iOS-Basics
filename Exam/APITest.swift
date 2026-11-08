import Foundation
import SwiftUI
import Observation

// MARK: Task hit api, error check, display results and do unit tests
struct APIResponse1: Decodable {
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

struct Make: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
}

protocol CarServiceProtocol {
    
    func fetch() async throws -> APIResponse1
    
}


struct APIService: CarServiceProtocol {
    
    let url = "https://carapi.app/api/makes/v2"
    
    func fetch() async throws -> APIResponse1 {
        
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
        
        return try JSONDecoder().decode(APIResponse1.self, from: data)
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
    
    func fetchMakes() async {
        do {
            makes = try await service.fetch().data
        } catch { viewState = .error(error.localizedDescription) }
        if makes.isEmpty { viewState = .empty }
        else {
            viewState = .loaded
        }
    }
    
    func search() {
        filteredMakes = makes.filter { make in
            make.name.contains(searchText)
        }
    }
}

struct ProgressView: View {
    
    var body: some View {
        Text("Loading...")
    }
}

struct EmptyView: View {
     
    var body: some View {
        Text("No manufacturers found !")
    }
}

struct CarListView: View {
    
    @State var viewModel: CarViewModel = CarViewModel(service: APIService())
    @State var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            switch viewModel.viewState {
            case .loading: ProgressView()
            case .empty: EmptyView()
            case .error(let error): Text(error)
            case .loaded:
                List(viewModel.filteredMakes) { make in
                    Text(make.name)
                        .navigationDestination(for: Routess.self) { routes in
                            RoutesBuilder().build(routes)
                        }
                }.searchable(text: $viewModel.searchText)
                    .refreshable { await viewModel.fetchMakes() }
                    
            }
        }.task { await viewModel.fetchMakes() }
    }
}

struct CarDetailView: View {
    
    let make: Make
    
    var body: some View {
        Text(" \(make.name) make has been selected")
    }
}


enum Routess: Hashable {
    case CarDetails(Make)
}

class RoutesBuilder {
    
    func build (_ route: Routess) -> AnyView {
        switch route {
        case .CarDetails(let make): return AnyView(CarDetailView(make: make))
        }
    }
}
