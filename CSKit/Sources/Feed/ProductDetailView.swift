import Components
import ComposableArchitecture
import Resources
import SwiftUI

public struct TestView: View {
	public init() {}
	
	public var body: some View {
		Color.red
	}
}

struct ProductDetailView: View {
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
								.font(.Raleway.fixed(.semibold, size: .h4))
								.foregroundStyle(AppColors.charlestonGreen.colorValue)

							Spacer()

							Text("R$ 9,99")
								.font(.Raleway.fixed(.bold, size: .h5))
								.foregroundStyle(AppColors.charlestonGreen.colorValue)
						}

						Text("Descrição")
							.font(.Raleway.fixed(.medium, size: .t1))
							.foregroundStyle(.gray)
					}

					Spacer()

					HStack {
						CSButton(
							title: "Carrinho",
							style: .dark
						)

						CSButton(title: "Comprar Agora")
					}
				}
				.padding(.horizontal, 32)
				.padding(.vertical, 40)
				.frame(minHeight: UIScreen.main.bounds.height * 0.45)
			}
			.background(.white)
			.clipShape(.rect(topLeadingRadius: 60))
			.scrollBounceBehavior(.basedOnSize)
		}
	}
}

#Preview {
	ProductDetailView()
}
