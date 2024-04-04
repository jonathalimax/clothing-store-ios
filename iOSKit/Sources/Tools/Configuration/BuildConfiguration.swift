import Foundation

public enum BuildConfiguration: String {
	case baseURL

	public var value: String? {
		do {
			return try fetchValue(for: rawValue)
		} catch {
			print("Error: fetching build configuration value for the key \(rawValue). \nVerbose: \(error.localizedDescription)")
			return nil
		}
	}
}

extension BuildConfiguration {
	private enum ReadError: Error {
		case notFound
	}

	private func fetchValue(for key: String) throws -> String? {
		if let value = Bundle.main.infoDictionary?[key] as? String {
			value
		} else {
			throw ReadError.notFound
		}
	}
}
