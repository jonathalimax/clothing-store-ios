import Feed
import SwiftUI
import Theme

struct ContentView: View {
	let theme: Theme = .avocado

    var body: some View {
		FeedView(theme: theme)
    }
}

#Preview {
    ContentView()
}
