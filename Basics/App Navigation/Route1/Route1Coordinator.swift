import SwiftUI

class Route1Coordinator {
    private func createView() -> some View {
        Route1View()
    }
}

extension Route1Coordinator {
    
    func start() -> some View { createView() }
}
