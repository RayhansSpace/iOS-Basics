import SwiftUI
import Observation

struct Route1View: View {
    
    var viewModel = Route1ViewModel()
    
    var body: some View {
        VStack{
            Text("Route 1")
            List(viewModel.makes) {
                Text($0.name)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.85, green: 0.93, blue: 0.98))
        .task { await viewModel.fetch() }
    }
}

@Observable
class Route1ViewModel {
    
    var makes: [DataModel] = []
    
    func fetch() async {
        do {
            let response = try await ApiService().fetch()
            makes = response.data
        } catch {
            print("Failed to fetch")
        }
    }
}
