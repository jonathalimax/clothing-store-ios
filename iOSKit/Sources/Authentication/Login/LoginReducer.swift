import ComposableArchitecture

@Reducer
public struct LoginReducer {
	@Dependency(\.authService) private var authService
	
	@ObservableState
	public struct State: Equatable {
		public init() {}
	}

	public enum Action: Equatable {
		case loginButtonTapped
		case userAuthenticated
		case delegate(Delegate)

		public enum Delegate {
			case authenticated
		}
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .loginButtonTapped:
				return authenticateUser()

			case .userAuthenticated:
				return .send(.delegate(.authenticated))

			case .delegate:
				return .none
			}
		}
	}
}

private extension LoginReducer {
	func authenticateUser() -> EffectOf<Self> {
		.run { send in
			if await authService.authenticateUser() {
				await send(.userAuthenticated)
			}
		}
	}
}
