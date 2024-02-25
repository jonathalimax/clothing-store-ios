import SwiftUI

public enum AppColors: String {
	case antiflashWhite
	case blueBlack
	case boogerBuster
	case charlestonGreen
	case lotion
	case darkBackground
	case white

	public var colorValue: Color {
		.init(rawValue, bundle: .module)
	}
}
