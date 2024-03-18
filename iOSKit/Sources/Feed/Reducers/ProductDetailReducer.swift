import Foundation
import ComposableArchitecture

@Reducer
public struct ProductDetailReducer {
	@ObservableState
	public struct State: Equatable {
		var galleryPresented: Bool = false
		var detailsPresented: Bool = false
		var cartTappedAmount: Int = .zero

		var descriptionLimit: Int? {
			detailsPresented ? nil : 6
		}

		public init(isPresented: Bool = false) {
			self.detailsPresented = isPresented
		}
	}

	public enum Action: Equatable, BindableAction {
		case imageTapped
		case buyButtonTapped
		case cartButtonTapped
		case galleryCloseTapped
		case detailsDraggedUp
		case seeMoreTapped
		case binding(BindingAction<State>)
	}

	public var body: some ReducerOf<Self> {
		BindingReducer()

		Reduce { state, action in
			switch action {
			case .imageTapped:
				state.galleryPresented = true
				return .none

			case .seeMoreTapped where state.detailsPresented:
				state.detailsPresented = false
				return .none

			case .detailsDraggedUp, .seeMoreTapped:
				state.detailsPresented = true
				return .none

			case .galleryCloseTapped:
				state.galleryPresented = false
				return .none

			case .cartButtonTapped:
				state.cartTappedAmount += 1
				return .none

			case .binding, .buyButtonTapped:
				return .none
			}
		}
	}
}
