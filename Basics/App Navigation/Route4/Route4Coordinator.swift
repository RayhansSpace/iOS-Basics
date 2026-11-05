import SwiftUI

class Route4Coordinator {
    private func createView(_ text: String) -> some View {
        Route4View(text: text)
    }
}

extension Route4Coordinator {

    func start(_ text: String) -> some View { createView(text) }
}