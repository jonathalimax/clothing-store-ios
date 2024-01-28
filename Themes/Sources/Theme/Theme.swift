import SwiftUI
import Avocado
import Baju

public enum Theme {
	case avocado
	case standard
}

extension Theme {
	public var product: some View {
		let view: any View

		switch self {
		case .avocado:
			view = Avocado.ProductView()

		case .standard:
			view = Baju.ProductView()
		}

		return AnyView(view)
	}
}
