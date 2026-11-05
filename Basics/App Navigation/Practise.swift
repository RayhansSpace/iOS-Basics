import SwiftUI

class RouteBuilder2 {
    
    static func build(_ route: Routes2) ->  AnyView {
        switch route {
        case .Route1:
            return AnyView(Route1Coordinator().start())
        case .Route2:
            return AnyView(Route2Coordinator().start())
        case .Route3:
            return AnyView(Route3Coordinator().start(""))
        }
    }
}

struct Home2View: View {
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            Text("Home2")
                .navigationDestination(for: Routes2.self) { routes in
                    RouteBuilder2.build(routes)
                }
        }
    }
}

enum Routes2 {
    case Route1
    case Route2
    case Route3
}
