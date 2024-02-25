import ComposableArchitecture

@Reducer
public struct ProductDetailReducer {
	@ObservableState
	public struct State: Equatable {
		var isPresented: Bool = false

		public init(isPresented: Bool = false) {
			self.isPresented = isPresented
		}
	}

	public enum Action: Equatable, BindableAction {
		case binding(BindingAction<State>)
	}

	public var body: some ReducerOf<Self> {
		BindingReducer()

		Reduce { state, action in
			return .none
		}
	}
}
