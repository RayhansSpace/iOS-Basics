import SwiftUI

class Route2Coordinator {
    private func createView() -> some View {
        Route2View()
    }
}

extension Route2Coordinator {
    
    func start() -> some View { createView() }
}
