import SwiftUI

public enum AppColors: String {
	case antiflashWhite
	case blueBlack
	case boogerBuster
	case charlestonGreen
	case lotion

	public var colorValue: Color {
		.init(rawValue, bundle: .module)
	}
}
