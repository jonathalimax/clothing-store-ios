import Theme
import ComposableArchitecture

@Reducer
public struct FeedReducer {
	@Dependency(\.tabBar) var tabBar
	@Dependency(\.feedService) var feedService

	@ObservableState
	public struct State: Equatable {
		@Presents var productDetail: ProductDetailReducer.State?
		var viewStatus: ViewStatus = .loading
		var theme: Theme
		var feed: Feed?

		public init(theme: Theme, feed: Feed? = nil) {
			self.theme = theme
			self.feed = feed
		}
	}

	public enum Action: Equatable {
		case viewAppeared
		case productTapped

		case feedFetched(Feed)
		case productDetail(PresentationAction<ProductDetailReducer.Action>)
	}

	public enum Cancellables {
		case fetchFeed
	}

	enum ViewStatus: Equatable {
		case loading
		case ready
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .viewAppeared:
				state.viewStatus = .loading
				tabBar.visibility.send(true)
				return fetchFeed()

			case .productTapped:
				state.productDetail = .init()
				return .none

			case .feedFetched(let feed):
				state.viewStatus = .ready
				state.feed = feed
				return .none

			case .productDetail:
				return .none
			}
		}
		.ifLet(\.$productDetail, action: \.productDetail) {
			ProductDetailReducer()
		}
	}
}

extension FeedReducer {
	private func fetchFeed() -> EffectOf<Self> {
		.run(
			operation: { send in
				let feed = try await feedService.fetch()
				await send(.feedFetched(feed))
			},
			catch: { error, _ in
				// TODO:  Handle error
				print(error)
			}
		)
		.cancellable(id: Cancellables.fetchFeed)
	}
}
