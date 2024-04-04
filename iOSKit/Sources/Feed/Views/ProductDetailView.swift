import Components
import ComposableArchitecture
import Resources
import SwiftUI
import Tools

struct ProductDetailView: View {
	@Bindable private var store: StoreOf<ProductDetailReducer>
	@Dependency(\.uuid) private var uuid
	@State private var isTabBarVisible: Bool = true

	init(store: StoreOf<ProductDetailReducer>) {
		self.store = store
	}

	var body: some View {
		GeometryReader { geometry in
			ZStack(alignment: .top) {
				AppColors.antiflashWhite.colorValue
					.ignoresSafeArea()

				VStack {
					ImageSelectorView(indexDisplayMode: .never)
						.frame(height: geometry.size.height * 0.6)
						.onTapGesture { store.send(.imageTapped) }

					detailView
						.padding(.top, -26)
						.shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 10)
				}
				.ignoresSafeArea()
			}
		}
		.simpleBackButton()
		.onAppear { store.send(.viewAppeared) }
		.sheet(isPresented: $store.detailsPresented) {
			detailView // TODO: Use another view instead
				.ignoresSafeArea()
		}
		.fullScreenCover(isPresented: $store.galleryPresented) {
			galleryView // TODO: Export gallery to proper file
				.ignoresSafeArea()
		}
	}

	private var detailView: some View {
		ZStack(alignment: .top) {
			AppColors.antiflashWhite.colorValue
				.ignoresSafeArea()

			VStack(spacing: 16) {
				RoundedRectangle(cornerRadius: 30)
					.fill(AppColors.charlestonGreen.colorValue)
					.frame(width: 48, height: 4)

				VStack(alignment: .leading, spacing: 12) {
					Group {
						Text("Crop Hoodie")
							.font(.Raleway.fixed(.medium, size: .h3))
							.foregroundStyle(AppColors.charlestonGreen.colorValue)
							.frame(maxWidth: .infinity, alignment: .leading)

						Text("R$ 9,99")
							.font(.Raleway.fixed(.bold, size: .h3))
							.foregroundStyle(AppColors.charlestonGreen.colorValue)
							.frame(maxWidth: .infinity, alignment: .leading)

						Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi accumsan enim nec est ornare, nec maximus eros viverra. Ut ac tellus dui. Nullam sed nisl ipsum. Donec imperdiet urna facilisis malesuada feugiat.")
							.font(.Raleway.fixed(.medium, size: .h6))
							.foregroundStyle(.gray)
							.lineLimit(store.descriptionLimit)
							.padding(.top)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.lineLimit(1)
				}

				if store.detailsPresented {
					sizeSelectorView

					colorSelectorView

					Spacer()
				}

				Button(action: { store.send(.seeMoreTapped) }) {
					Text(store.detailsPresented ? "Menos detalhes" : "Mais detalhes")
						.foregroundStyle(AppColors.charlestonGreen.colorValue)
						.frame(maxWidth: .infinity, minHeight: 48)
						.font(.Raleway.fixed(.bold, size: .t1))
				}

				callToActionView
			}
			.padding([.horizontal, .top])
			.padding(.bottom, 32)
		}
		.clipShape(.rect(topLeadingRadius: 20, topTrailingRadius: 20))
	}

	private var colorSelectorView: some View {
		VStack(alignment: .leading) {
			Text("Cores")
				.font(.Raleway.fixed(.semibold, size: .h6))

			ColorSelectorView([
				.init(id: uuid(), color: .white),
				.init(id: uuid(), color: .pink),
				.init(id: uuid(), color: .blue),
				.init(id: uuid(), color: .yellow),
				.init(id: uuid(), color: .green),
				.init(id: uuid(), color: .purple),
				.init(id: uuid(), color: .orange),
			]) { _ in }
		}
		.padding(.top, 6)
	}

	private var sizeSelectorView: some View {
		VStack(alignment: .leading) {
			Text("Tamanhos")
				.font(.Raleway.fixed(.semibold, size: .h6))

			SizeSelectorView { _ in }
		}
		.padding(.top, 6)
	}

	private var callToActionView: some View {
		HStack(spacing: 16) {
			Button(action: { store.send(.cartButtonTapped) }) {
				Image(systemName: "cart.fill")
			}
			.frame(width: 60)
			.buttonStyle(CSButtonStyle(.dark))
			.sensoryFeedback(.increase, trigger: store.cartTappedAmount) // TODO: Test haptic

			Button(action: { store.send(.buyButtonTapped) }) {
				Text("Comprar")
			}
			.buttonStyle(CSButtonStyle(.light))
		}
	}

	private var galleryView: some View {
		ZStack(alignment: .topTrailing) {
			ImageSelectorView()

			Button(action: { store.send(.galleryCloseTapped) }) {
				Image(systemName: "xmark")
					.font(.system(size: 18, weight: .medium))
					.foregroundStyle(AppColors.charlestonGreen.colorValue)
			}
			.frame(width: 42, height: 42)
			.background(.ultraThinMaterial)
			.clipShape(.rect(cornerRadius: 18))
			.padding(.trailing, 24)
			.padding(.top, 60)
		}
	}
}

private extension CGFloat {
	static let threshold: Self = -10
}

#Preview("Light") {
	ProductDetailView(store: .init(initialState: .init()) {
		ProductDetailReducer()
	})
}

#Preview("Dark") {
	ProductDetailView(store: .init(initialState: .init()) {
		ProductDetailReducer()
	})
	.preferredColorScheme(.dark)
}
