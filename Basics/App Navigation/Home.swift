import SwiftUI

struct HomeView: View {
    
    @State private var text = ""
    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            
            VStack(spacing: 12) {
                Text("Navigation 101")
                    .font(.largeTitle)
                    .bold()
                Button("Route 1") {
                    path.append(Routes.route1)
                }
                .buttonStyle(ButtonStyle1(color: Color(red: 0.85, green: 0.93, blue: 0.98)))

                Button("Route 2") {
                    path.append(Routes.route2)
                }
                .buttonStyle(ButtonStyle1(color: Color(red: 1.0, green: 0.82, blue: 0.82)))

                Button("Route 3") {
                    path.append(Routes.route3(text))
                }
                .buttonStyle(ButtonStyle1(color: Color(red: 0.82, green: 0.95, blue: 0.82)))
                
                Spacer().frame(height: 12)
                
                TextField("Enter Text...", text: $text)
            }
            .containerRelativeFrame(.horizontal) { width, _ in
                width * 0.75
            }
            .navigationDestination(for: Routes.self) { route in
                AppRouteBuilder.build(route)
            }
        }
    }
}


struct ButtonStyle1: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(12)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}
