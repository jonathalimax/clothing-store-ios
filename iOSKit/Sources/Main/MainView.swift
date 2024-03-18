import Authentication
import Components
import ComposableArchitecture
import Feed
import Profile
import Resources
import Theme
import SwiftUI

public struct MainView: View {
	@Bindable private var store: StoreOf<MainReducer>

	public init(store: StoreOf<MainReducer>) {
		self.store = store
	}

	public var body: some View {
		Group {
			switch store.viewStatus {
			case .loading:
				loadingView

			case .ready:
				mainContent
			}
		}
		.onAppear {
			store.send(.didAppear)
		}
		.fullScreenCover(
			item: $store.scope(state: \.loginState, action: \.loginAction),
			content: LoginView.init
		)
	}

	private var loadingView: some View {
		ZStack {
			AppColors.antiflashWhite.colorValue

			AnimationView(.loading)
				.frame(width: 100, height: 100)
		}
		.ignoresSafeArea()
	}

	private var mainContent: some View {
		TabView {
			Group {
				FeedView(store: store.scope(state: \.feedState, action: \.feedAction))
					.tabItem {
						Image(.trending)
					}

				ProfileView(store: store.scope(state: \.profileState, action: \.profileAction))
					.tabItem {
						Image(systemName: "person.crop.circle.fill")
					}
			}
			.toolbarBackground(.visible, for: .tabBar)
			.toolbarBackground(.clear, for: .tabBar)
		}
	}
}

#Preview("Light") {
	MainView(store: .init(initialState: .init()) {
		MainReducer()
	})
}

#Preview("Dark") {
	MainView(store: .init(initialState: .init()) {
		MainReducer()
	})
	.preferredColorScheme(.dark)
}
