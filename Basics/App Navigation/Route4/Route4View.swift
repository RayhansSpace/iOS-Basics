import SwiftUI

struct Route4View: View {

    let text: String

    var body: some View {
        VStack{
            Text("Route 4")
            Text(text)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.98, green: 0.95, blue: 0.78))
    }
}