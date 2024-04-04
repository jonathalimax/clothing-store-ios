import Authentication
import Components
import ComposableArchitecture
import Feed
import Profile
import Resources
import SwiftUI
import Theme
import Tools
import UI

public struct MainView: View {
	@Bindable private var store: StoreOf<MainReducer>

	public init(store: StoreOf<MainReducer>) {
		self.store = store
	}

	public var body: some View {
		FloatTabView(
			tabs: [
				.init(
					id: 0,
					icon: "newspaper",
					selectedIcon: "newspaper.fill",
					screen: FeedView(store: store.scope(state: \.feedState, action: \.feedAction))
				),
				.init(
					id: 1,
					icon: "cart",
					selectedIcon: "cart.fill",
					screen: Color.black
				),
				.init(
					id: 2,
					icon: "person",
					selectedIcon: "person.fill",
					screen: ProfileView(store: store.scope(state: \.profileState, action: \.profileAction))
				)
			]
		)
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
