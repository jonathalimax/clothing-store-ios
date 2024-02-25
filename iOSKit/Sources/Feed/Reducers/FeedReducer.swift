import Theme
import ComposableArchitecture

@Reducer
public struct FeedReducer {
	@ObservableState
	public struct State: Equatable {
		@Presents var productDetail: ProductDetailReducer.State?
		var theme: Theme

		public init(theme: Theme) {
			self.theme = theme
		}
	}

	public enum Action: Equatable {
		case productTapped
		case productDetail(PresentationAction<ProductDetailReducer.Action>)
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .productTapped:
				state.productDetail = .init()
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
