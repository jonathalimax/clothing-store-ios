import Components
import ComposableArchitecture
import Resources
import SwiftUI

struct ProductDetailView: View {
	@Bindable var store: StoreOf<ProductDetailReducer>

	init(store: StoreOf<ProductDetailReducer>) {
		self.store = store
	}

	var body: some View {
		ZStack {
			GeometryReader { geometry in
				Color.white
					.ignoresSafeArea()
					.frame(height: geometry.size.height * 0.5)

				AppColors.antiflashWhite.colorValue
					.clipShape(.rect(bottomTrailingRadius: 60))
					.ignoresSafeArea()
					.frame(height: geometry.size.height * 0.5)

				VStack(alignment: .trailing, spacing: .zero) {
					ImageSelectorView(
						images: [
							.init(string: "https://i.pinimg.com/originals/88/1f/61/881f615abd6b80ee5c33f13ad22eadbd.png")!,
							.init(string: "https://i.ibb.co/jL7t3QG/loja-de-roupas-femininas-online-removebg-preview.png")!,
						]
					)
					.frame(height: geometry.size.height * 0.5)

					detailView
						.ignoresSafeArea()
				}
			}
		}
		.sheet(isPresented: $store.isPresented) {
			detailView // TODO: Use another view instead
				.ignoresSafeArea()
		}
		.ignoresSafeArea(edges: .bottom)
	}

	private var detailView: some View {
		ZStack {
			AppColors.antiflashWhite.colorValue
				.ignoresSafeArea()

			ScrollView(showsIndicators: false) {
				VStack(spacing: 48) {
					VStack(alignment: .leading, spacing: 12) {
						HStack {
							Text("Crop Hoodie")
								.font(.Raleway.fixed(.semibold, size: .h5))
								.foregroundStyle(.black)

							Spacer()

							Text("R$ 9,99")
								.font(.Raleway.fixed(.bold, size: .h5))
								.foregroundStyle(.black)
						}

						Text("Descrição")
							.font(.Raleway.fixed(.medium, size: .t1))
							.foregroundStyle(.gray)
					}

					Spacer()

					callToActionView
				}
				.padding(.horizontal, 32)
				.padding(.vertical, 40)
				.frame(minHeight: UIScreen.main.bounds.height * 0.4)
			}
			.background(.white)
			.clipShape(.rect(topLeadingRadius: store.isPresented ? .zero : 60))
			.scrollBounceBehavior(.basedOnSize)
		}
	}

	private var callToActionView: some View {
		HStack {
			Button(action: { store.isPresented = true }) {
				Text("Carrinho")
			}
			.buttonStyle(CSButtonStyle(.dark))

			Button(action: { store.isPresented = true }) {
				Text("Comprar")
			}
			.buttonStyle(CSButtonStyle(.light))
		}
	}
}

#Preview {
	ProductDetailView(store: .init(initialState: .init()) {
		ProductDetailReducer()
	})
}
