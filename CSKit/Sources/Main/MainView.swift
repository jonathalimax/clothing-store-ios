import Resources
import Feed
import Theme
import SwiftUI

public struct MainView: View {
	public init() {}

	public var body: some View {
		TabView {
			Group {
				FeedView(theme: .avocado)
					.tabItem {
						Image(.trending)
					}

				Text("tab2")
					.tabItem {
						Image(systemName: "person.crop.circle.fill")
					}
			}
			.toolbarBackground(.visible, for: .tabBar)
			.toolbarBackground(AppColors.antiflashWhite.colorValue.opacity(0.1), for: .tabBar)
		}
	}
}

#Preview {
	MainView()
}
