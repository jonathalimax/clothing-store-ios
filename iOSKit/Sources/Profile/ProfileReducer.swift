import Authentication
import ComposableArchitecture

@Reducer
public struct ProfileReducer {
	@Dependency(\.authService) private var authService

	@ObservableState
	public struct State: Equatable {
		var changeColor: Bool = false
		public init() {}
	}

	public enum Action: Equatable {
		case logoutTapped
		case delegate(Delegate)

		public enum Delegate {
			case logout
		}
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
				case .logoutTapped:
				state.changeColor = true
				return .concatenate(
					.run{ _ in authService.logout() },
					.send(.delegate(.logout))
				)

			case .delegate:
				return .none
			}
		}
	}
}
