import Foundation

// MARK: - Feed
public struct Feed: Codable, Equatable {
	let categories: [Category]
}

// MARK: - Category
extension Feed {
	public struct Category: Codable, Equatable {
		let category, name: String
		let products: [Product]
	}
}

// MARK: - Product
extension Feed {
	public struct Product: Codable, Equatable {
		let id: Int
		let name: String
		let description: String
		let price: Double
		let promotionalPrice: Double?
		let photos: [String]
		let colors: [Color]
		let sizes: [Size]
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
	public struct Size: Codable, Equatable {
		let size: String
	}
}
