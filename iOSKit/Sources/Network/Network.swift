import Foundation
import Tools

public struct Network {
	public func call<T: Decodable>(_ method: Method, _ endpoint: Endpoint) async throws -> T {
		let response = try await URLSession.shared.data(
			for: .buildRequest(
				method: method,
				endpoint: endpoint
			)
		)

		return try JSONDecoder.shared.decode(T.self, from: response.0)
	}
}

// MARK: - HTTP Method
extension Network {
	public enum Method: String {
		case get, post
	}
}

// MARK: - Endpoint
extension Network {
	public enum Endpoint {
		case feed(Feed)

		var path: String {
			switch self {
			case .feed(let path):
				return path.rawValue
			}
		}
	}

	// MARK: Feed
	public enum Feed: String {
		case base = "feed"
	}
}

extension Network.Endpoint {
	func buildURL() throws -> URL {
		// TODO: Move base URL to build configuration
		guard var url = URL(string: "https://cf46a0fb-3cf3-4c0b-ae57-80869caa128e.mock.pstmn.io") else {
			throw NetworkError.badConfiguration
		}
		
		url.append(path: self.path)

		return url
	}
}

// MARK: - URLRequest factory
extension URLRequest {
	static func buildRequest(
		method: Network.Method,
		endpoint: Network.Endpoint,
		body: (any Encodable)? = nil
	) throws -> Self {
		var request = URLRequest(url: try endpoint.buildURL())
			.withStandardHeaderValues()

		request.httpMethod = method.rawValue

		if let body {
			request.httpBody = try JSONEncoder.shared.encode(body)
		}

		return request
	}

	@discardableResult
	private func withStandardHeaderValues() -> Self {
		var mutableSelf = self
		mutableSelf.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return mutableSelf
	}
}
