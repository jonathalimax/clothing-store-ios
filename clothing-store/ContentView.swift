import SwiftUI
import Theme

struct ContentView: View {
	let theme: Theme = .standard
    var body: some View {
		theme.product
    }
}

#Preview {
    ContentView()
}
