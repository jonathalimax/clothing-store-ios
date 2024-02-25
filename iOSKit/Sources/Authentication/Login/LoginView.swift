import Components
import ComposableArchitecture
import Resources
import SwiftUI

public struct LoginView: View {
	@Bindable private var store: StoreOf<LoginReducer>

	public init(store: StoreOf<LoginReducer>) {
		self.store = store
	}

	public var body: some View {
		ZStack {
			AppColors.boogerBuster.colorValue
				.ignoresSafeArea()

			VStack(spacing: 32) {
				Text("Seja muito bem vinda a **Clareiamô**!")
					.font(.Raleway.fixed(.medium, size: .h1))
					.foregroundStyle(AppColors.darkBackground.colorValue)
					.frame(maxWidth: .infinity, alignment: .leading)

				Text("Vista-se de si mesma!")
					.font(.Raleway.fixed(.medium, size: .h5))
					.foregroundStyle(AppColors.darkBackground.colorValue)
					.frame(maxWidth: .infinity, alignment: .leading)

				AnimationView(.login)

				Button(action: { store.send(.loginButtonTapped) }) {
					Label(
						title: { Text("Entrar com Apple") },
						icon: { Image(systemName: "apple.logo") }
					)
				}
				.buttonStyle(CSButtonStyle(.dark))
			}
			.padding(.horizontal)
			.padding(.vertical, 48)
		}
	}
}

#Preview {
	LoginView(store: .init(initialState: .init()) {
		LoginReducer()
	})
}
