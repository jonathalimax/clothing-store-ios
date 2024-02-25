import Foundation
import Dependencies
import Security

@propertyWrapper
public struct Keychain {
	private let key: Key

	public init(_ key: Key) {
		self.key = key
	}

	public var wrappedValue: String? {
		get {
			getValue(for: key)
		}
		set {
			guard let newValue else { return delete() }
			persist(value: newValue)
		}
	}
}

public extension Keychain {
	enum Key: String {
		/// Apple's sign in user ID
		case userID

		var tag: Any {
			rawValue.data(using: .utf8) as Any
		}
	}
}

private extension Keychain {
	var commonQuery: [String: Any] {
		[
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrService as String: String.bundleID,
			kSecAttrAccount as String: key.rawValue
		]
	}

	func persist(value: String) {
		guard let data = value.data(using: .utf8) else { return }

		var addQuery = commonQuery
		addQuery[kSecValueData as String] = data

		SecItemAdd(addQuery as CFDictionary, nil)
	}

	func getValue(for key: Key) -> String? {
		var query = commonQuery
		query[kSecReturnData as String] = true
		query[kSecMatchLimit as String] = kSecMatchLimitOne

		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)
		guard
			status == errSecSuccess,
			let item = item as? Data
		else { return nil }

		return String(data: item, encoding: .utf8)
	}

	func delete() {
		let query = commonQuery
		let status = SecItemDelete(query as CFDictionary)

		if status == errSecSuccess {
			print("Successfully deleted the item from the keychain.")
		} else {
			print("Error deleting item from keychain. Status: \(status)")
		}
	}
}

private extension String {
	static let bundleID: Self = "com.jlima.clothing.store"
}
