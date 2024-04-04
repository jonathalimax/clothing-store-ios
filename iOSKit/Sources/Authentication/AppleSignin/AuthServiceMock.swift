class AuthServiceMock: AuthServiceProtocol {
	func authenticateUser() async -> Bool { true }

	func isCredentialsValid() async throws -> Bool { true }

	func logout() {}
}
