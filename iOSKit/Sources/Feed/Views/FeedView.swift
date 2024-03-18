import Components
import ComposableArchitecture
import Resources
import SwiftUI
import Theme

public struct FeedView: View {
	@Bindable var store: StoreOf<FeedReducer>

	public init(store: StoreOf<FeedReducer>) {
		self.store = store
	}

	public var body: some View {
		NavigationStack {
			ZStack(alignment: .top) {
				AppColors.antiflashWhite.colorValue
					.ignoresSafeArea()

				ScrollView() {
					VStack(spacing: 16) {
						headerView
							.padding([.top, .horizontal])

						bannersView

						categoriesView
							.padding(.horizontal)
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.bottom)
				}
			}
			.onAppear { store.send(.viewAppeared) }
			.navigationTitle("Olá, Paloma!")
			.toolbarBackground(.clear, for: .navigationBar)
			.navigationDestination(
				item: $store.scope(state: \.productDetail, action: \.productDetail),
				destination: {
					ProductDetailView(store: $0)
						.toolbar(.hidden, for: .tabBar)
				}
			)
		}
	}

	private var headerView: some View {
		HStack(spacing: 12) {
			SearchBarView {}

			cartView
		}
	}

	private var cartView: some View {
		Button(action: {}) {
			Image(.shoppingBag)
				.resizable()
				.aspectRatio(contentMode: .fit)
				.colorMultiply(.white)
				.padding()
				.frame(width: 68, height: 60)
				.background(.ultraThickMaterial)
				.clipShape(.rect(cornerRadius: 26))
		}
	}

	private var categoriesView: some View {
		VStack(alignment: .leading, spacing: 22) {
			if let categories = store.feed?.categories {
				ForEach(categories, id: \.type) { category in
					VStack(alignment: .leading, spacing: 22) {
						Text(category.name)
							.font(.Raleway.fixed(.bold, size: .h3))

						productsView(category.products)
					}
				}
			}
		}
	}

	@ViewBuilder
	private var bannersView: some View {
		if let banners = store.feed?.banners, !banners.isEmpty {
			BannerView(banners: banners.bannersAdapted)
				.frame(height: 160)
				.padding(.top)
		}
	}

	private func productsView(_ products: [Feed.Product]) -> some View {
		let columns: [GridItem] = Array(
			repeating: .init(.flexible(), spacing: 20),
			count: 2
		)

		return LazyVGrid(columns: columns, spacing: 22) {
			ForEach(products, id: \.id) {
				store.theme.productView(data: $0.productAdapted)
					.onTapGesture { store.send(.productTapped) }
					.frame(height: 290)
			}
		}
		.padding(.top)
	}
}

// MARK: - Adapters
private extension Feed.Product {
	var productAdapted: Theme.Product.Data {
		.init(name: self.name, price: self.displayPrice, images: self.photosURL)
	}
}

private extension [Feed.Banner] {
	var bannersAdapted: [BannerView.Data] {
		self.map {
			.init(
				id: $0.id,
				title: $0.title,
				subtitle: $0.subtitle,
				description: $0.description
			)
		}
	}
}

// MARK: - Preview
#Preview("Light") {
	FeedView(store: .init(initialState: .init(theme: .avocado, feed: .mock)) {
		FeedReducer()
	})
}

#Preview("Dark") {
	FeedView(store: .init(initialState: .init(theme: .avocado, feed: .mock)) {
		FeedReducer()
	})
	.preferredColorScheme(.dark)
}
