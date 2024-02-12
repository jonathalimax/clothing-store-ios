import SwiftUI

public enum LocalImage: String {
	case magnifyingGlass
	case shoppingBag
	case pinkLook
}

public extension Image {
	init(_ localImage: LocalImage) {
		self.init(localImage.rawValue, bundle: .module)
	}
}
