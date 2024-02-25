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
		HStack(spacing: 16) {
			SearchBarView {}

			cartView
		}
	}

	private var cartView: some View {
		Button(action: {}) {
			ZStack {
				AppColors.lotion.colorValue

				VStack(spacing: 16) {
					Image(.shoppingBag)
						.resizable()
						.padding()
				}
			}
			.frame(width: 60, height: 60)
			.clipShape(Circle())
		}
	}

	private var productsView: some View {
		let columns: [GridItem] = Array(
			repeating: .init(.flexible(), spacing: 12),
			count: 2
		)

		return VStack(alignment: .leading, spacing: 12) {
			Text("Produtos")
				.font(.Raleway.fixed(.bold, size: .h5))

			LazyVGrid(columns: columns, spacing: 12) {
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

#Preview {
	FeedView(store: .init(initialState: .init(theme: .avocado)) {
		FeedReducer()
	})
}
