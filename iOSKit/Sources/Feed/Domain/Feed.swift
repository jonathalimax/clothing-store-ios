import Foundation
import Tools

// MARK: - Feed
public struct Feed: Codable, Equatable {
	let banners: [Banner]
	let categories: [Category]
}

// MARK: - Banner
extension Feed {
	public struct Banner: Codable, Equatable {
		let id: Int
		let title, subtitle, description: String
		let image: String?
	}
}

// MARK: - Category
extension Feed {
	public enum CategoryType: String, Codable, Identifiable {
		case highlight

		public var id: String { rawValue }
	}

	public struct Category: Codable, Equatable {
		let type: CategoryType
		let name: String
		let products: [Product]
	}
}

// MARK: - Product
extension Feed {
	public struct Product: Codable, Equatable {
		let id: Int
		let name, description: String
		let price: Decimal
		let promotionalPrice: Decimal?
		let photos: [String]
		let colors: [Color]
		let sizes: [Size]

		var displayPrice: String {
			NumberFormatter.currency.string(price)
		}

		var displayPromotionalPrice: String? {
			guard let promotionalPrice else { return nil }
			return NumberFormatter.currency.string(promotionalPrice)
		}

		var photosURL: [URL] { photos.compactMap(URL.init) }
	}
}

// MARK: - Color
extension Feed.Product {
	public struct Color: Codable, Equatable {
		let id: Int
		let name, rgb: String
	}
}

// MARK: - Size
extension Feed.Product {
	public enum Size: String, Codable, Equatable, Identifiable {
		case small
		case medium
		case large
		case extraLarge

		public var id: String { rawValue }
	}
}
