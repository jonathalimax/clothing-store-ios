import ComposableArchitecture
import Resources
import SwiftUI

public struct ProfileView: View {
	let store: StoreOf<ProfileReducer>

	public init(store: StoreOf<ProfileReducer>) {
		self.store = store
	}

	public var body: some View {
		ZStack {
			AppColors.charlestonGreen.colorValue
			
			Button(action: { store.send(.logoutTapped) }) {
				Text("Logout")
			}

			if store.changeColor {
				Text("Changed")
			}
		}
		.ignoresSafeArea()
	}
}

#Preview {
	ProfileView(store: .init(initialState: .init()) {
		ProfileReducer()
	})
}
