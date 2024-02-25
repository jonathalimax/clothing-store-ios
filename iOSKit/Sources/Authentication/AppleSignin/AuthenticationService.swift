import AuthenticationServices
import Dependencies
import Services

public final class AuthService: NSObject {
	@Keychain(.userID) private var userID
	private let appleIDProvider: ASAuthorizationAppleIDProvider
	private var authenticationCompletion: ((_ succeed: Bool) -> Void)?

	public init(appleIDProvider: ASAuthorizationAppleIDProvider = .init()) {
		self.appleIDProvider = appleIDProvider
	}

	public func authenticateUser() async -> Bool {
		let request = appleIDProvider.createRequest()
		request.requestedScopes = [.email, .fullName]

		let authorizationController = ASAuthorizationController(authorizationRequests: [request])
		authorizationController.delegate = self
		authorizationController.performRequests()

		return await withCheckedContinuation { continuation in
			authenticationCompletion = { succeed in
				continuation.resume(returning: succeed)
			}
		}
	}

	public func isCredentialsValid() async throws -> Bool {
		try await withUnsafeThrowingContinuation { continuation in
			guard userID != nil else {
				return continuation.resume(returning: false)
			}

			appleIDProvider.getCredentialState(forUserID: userID ?? "") { state, error in
				if let error {
					return continuation.resume(throwing: error)
				}

				switch state {
				case .authorized:
					continuation.resume(returning: true)

				case .notFound, .revoked, .transferred:
					continuation.resume(returning: false)

				@unknown default:
					continuation.resume(returning: false)
				}
			}
		}
	}

	public func logout() -> Void {
		userID = nil
	}
}

// MARK: - ASAuthorizationControllerDelegate
extension AuthService: ASAuthorizationControllerDelegate {
	public func authorizationController(
		controller: ASAuthorizationController,
		didCompleteWithAuthorization authorization: ASAuthorization
	) {
		authenticationCompletion?(true)

		switch authorization.credential {
		case let appleIDCredential as ASAuthorizationAppleIDCredential:
			self.userID = appleIDCredential.user

			print("user: ", appleIDCredential.user)
			print("email: ", appleIDCredential.email ?? "NA")
			print("fullName: ", appleIDCredential.fullName ?? "NA")

		case let passwordCredential as ASPasswordCredential:
			// TODO: Handle?
			print(passwordCredential.user)
			print(passwordCredential.password)

		default:
			break
		}
	}

	public func authorizationController(
		controller: ASAuthorizationController,
		didCompleteWithError error: Error
	) {
		authenticationCompletion?(false)
		print("ASAuthorizationController error", error.localizedDescription)
	}
}

// MARK: - Dependecy Registration
extension AuthService: DependencyKey {
	public static let liveValue: AuthService = .init()
	public static let testValue: AuthService = .init(appleIDProvider: AppleIDProviderMock())
	public static let previewValue: AuthService = .init(appleIDProvider: AppleIDProviderMock())
}

extension DependencyValues {
	public var authService: AuthService {
		get { self[AuthService.self] }
		set { self[AuthService.self] = newValue }
	}
}
