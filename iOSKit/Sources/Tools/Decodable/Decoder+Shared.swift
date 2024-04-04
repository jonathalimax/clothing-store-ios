import Foundation

extension JSONEncoder {
	public static var shared: JSONEncoder {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		return encoder
	}
}
