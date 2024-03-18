import Dependencies

extension Network: DependencyKey {
	public static var liveValue: Network = .init()
}

extension DependencyValues {
	public var network: Network {
		get { self[Network.self] }
		set { self[Network.self] = newValue }
	}
}
