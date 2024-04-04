import Foundation

extension JSONDecoder {
	public static var shared: JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}

	public func decode<T: Decodable>(_ type: T.Type, string: String) -> T? {
		guard let data = string.data(using: .utf8) else { return nil }
		return try? JSONDecoder.shared.decode(type, from: data)
	}
}
