import SwiftUI

public enum AppColors: String {
	case antiflashWhite
	case blueBlack

	public var colorValue: Color {
		.init(rawValue, bundle: .module)
	}
}
