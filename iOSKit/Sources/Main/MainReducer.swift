import Authentication
import ComposableArchitecture
import Feed
import Profile
import Theme

@Reducer
public struct MainReducer {
	@Dependency(\.authService) var authService

	@ObservableState
	public struct State: Equatable {
		@Presents var loginState: LoginReducer.State?
		var feedState: FeedReducer.State
		var profileState: ProfileReducer.State

		public init(
			loginState: LoginReducer.State? = nil,
			feedReducer: FeedReducer.State = .init(theme: .avocado),
			profileState: ProfileReducer.State = .init()
		) {
			self.loginState = loginState
			self.feedState = feedReducer
			self.profileState = profileState
		}
	}

	public enum Action: Equatable {
		case didAppear
		case credentialsVerified(_ isValid: Bool)
		case loginAction(PresentationAction<LoginReducer.Action>)
		case feedAction(FeedReducer.Action)
		case profileAction(ProfileReducer.Action)
	}

	public init() {}

	public var body: some ReducerOf<Self> {
		Scope(state: \.feedState, action: \.feedAction) {
			FeedReducer()
		}
		Scope(state: \.profileState, action: \.profileAction) {
			ProfileReducer()
		}

		Reduce { state, action in
			switch action {
			case .didAppear:
				return validateCredentials()

			case .credentialsVerified(isValid: true):
				return .none

			case .credentialsVerified(isValid: false):
				state.loginState = .init()
				return .none

			case .loginAction(.presented(.delegate(.authenticated))):
				state.loginState = nil
				return .none

			case .profileAction(.delegate(.logout)):
				state.profileState = .init()
				state.loginState = .init()
				return .none

			case .loginAction, .feedAction, .profileAction:
				return .none
			}
		}
		.ifLet(\.$loginState, action: \.loginAction) {
			LoginReducer()
		}
	}
}

private extension MainReducer {
	// TODO: Improve
	func validateCredentials() -> EffectOf<Self> {
		.run { send in
			let isValid = try await authService.isCredentialsValid()
			await send(.credentialsVerified(isValid))
		} catch: { _, send in
			await send(.credentialsVerified(false))
		}
	}
}
