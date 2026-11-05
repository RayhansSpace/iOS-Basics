import SwiftUI

class Route3Coordinator {
    private func createView(_ text: String) -> some View {
        Route3View(text: text)
    }
}

extension Route3Coordinator {
    
    func start(_ text: String) -> some View { createView(text) }
}

