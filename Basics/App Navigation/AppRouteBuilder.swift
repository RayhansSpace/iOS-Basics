import SwiftUI


class AppRouteBuilder {
    
    static func build(_ route: Routes) -> AnyView {
        switch route {
            case .route1:
            return AnyView(Route1Coordinator().start())
        case .route2:
            return AnyView(Route2Coordinator().start())
        case .route3(let text):
            return AnyView(Route3Coordinator().start(text))
        case .route4(let text):
            return AnyView(Route4Coordinator().start(text))
        }
    }
}
