import ComposableArchitecture
import Resources
import SwiftUI

public struct ProfileView: View {
	let store: StoreOf<ProfileReducer>

	public init(store: StoreOf<ProfileReducer>) {
		self.store = store
	}

	public var body: some View {
		NavigationStack {
			ZStack {
				AppColors.antiflashWhite.colorValue
			}
			.ignoresSafeArea()
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button(action: { store.send(.logoutTapped) }) {
						Text("Logout")
					}
				}
			}
		}
	}
}

#Preview {
	ProfileView(store: .init(initialState: .init()) {
		ProfileReducer()
	})
}
