import SwiftUI
import Avocado
import Baju

extension Theme {
	public enum Product {
		public struct Data {
			let name, price: String
			let images: [URL]

			public init(name: String, price: String, images: [URL]) {
				self.name = name
				self.price = price
				self.images = images
			}
		}
	}

	public func productView(data: Theme.Product.Data) -> some View {
		let view: any View

		switch self {
		case .avocado:
			view = Avocado.ProductView(
				data: .init(
					name: data.name,
					price: data.price,
					images: data.images
				)
			)

		case .standard:
			view = Baju.ProductView()
		}

		return AnyView(view)
	}
}
