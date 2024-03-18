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

						BannerView(imageURL: "https://i.ibb.co/bXxtkfy/Subject-2.png")
							.padding(.top)

						productsView
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

	private var productsView: some View {
		let columns: [GridItem] = Array(
			repeating: .init(.flexible(), spacing: 20),
			count: 2
		)

		return VStack(alignment: .leading, spacing: 22) {
			Text("Produtos")
				.font(.Raleway.fixed(.bold, size: .h3))

			LazyVGrid(columns: columns, spacing: 22) {
				ForEach(0...9, id: \.self) { _ in
					store.theme.productView
						.onTapGesture { store.send(.productTapped) }
						.frame(height: 290)
				}
			}
		}
		.padding(.top)
	}
}

#Preview("Light") {
	FeedView(store: .init(initialState: .init(theme: .avocado)) {
		FeedReducer()
	})
}

#Preview("Dark") {
	FeedView(store: .init(initialState: .init(theme: .avocado)) {
		FeedReducer()
	})
	.preferredColorScheme(.dark)
}
