import Network
import Dependencies

public struct FeedService {
	public private(set) var fetch: () async throws -> Feed
}

extension FeedService {
	public static func live(network: Network) -> Self {
		.init(
			fetch: { try await network.call(.get, .feed(.base)) }
		)
	}
}

// MARK: - Dependency register
extension FeedService: DependencyKey {
	public static var liveValue: FeedService = {
		@Dependency(\.network) var network
		return .live(network: network)
	}()
}

extension DependencyValues {
	public var feedService: FeedService {
		get { self[FeedService.self] }
		set { self[FeedService.self] = newValue }
	}
}
