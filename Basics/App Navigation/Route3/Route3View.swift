import SwiftUI

struct Route3View: View {
    
    let text: String
    
    var body: some View {
        VStack{
            Text("Route 3")
            Text(text)
            NavigationLink(value: Routes.route4(text)) {
                Text("Further navigation")
            }
            // MARK: To explore further navigation using button (@escaping closure)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.82, green: 0.95, blue: 0.82))
    }
}
