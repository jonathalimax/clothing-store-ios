import Resources
import Components
import SwiftUI
import Theme

public struct FeedView: View {
	private var theme: Theme

	public init(theme: Theme) {
		self.theme = theme
	}

	public var body: some View {
		ZStack(alignment: .top) {
			AppColors.antiflashWhite.colorValue
				.ignoresSafeArea()

			ScrollView() {
				VStack(spacing: 22) {
					headerView
						.padding(.horizontal)

					SearchBarView {}
						.padding(.horizontal)

					BannerView(imageURL: "https://i.ibb.co/bXxtkfy/Subject-2.png")
						.padding(.top)

					productsView
						.padding(.horizontal)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.vertical)
			}
		}
	}

	private var headerView: some View {
		HStack {
			VStack(alignment: .leading, spacing: 6) {
				Text("Oi Paloma")
					.font(.Raleway.fixed(.semibold, size: .t1))

				Text("Qual será o look de hoje?")
					.font(.Raleway.fixed(.bold, size: .h5))
			}

			Spacer()

			ZStack {
				Color.white.opacity(0.6)

				Image(.shoppingBag)
					.resizable()
					.padding()
			}
			.frame(width: 60, height: 60)
			.clipShape(Circle())
		}
		.padding(.horizontal)
	}

	private var productsView: some View {
		let columns: [GridItem] = Array(
			repeating: .init(.flexible(), spacing: 16),
			count: 2
		)

		return VStack(alignment: .leading, spacing: 22) {
			Text("Produtos")
				.font(.Raleway.fixed(.bold, size: .h5))

			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(0...9, id: \.self) { _ in
					theme.productView
						.frame(height: 260)
				}
			}
		}
		.padding(.top)
	}
}

#Preview {
	FeedView(theme: .avocado)
}
