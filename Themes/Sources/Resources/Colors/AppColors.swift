import SwiftUI

public enum AppColors: String {
	case antiflashWhite
	case blueBlack
	case boogerBuster
	case charlestonGreen

	public var colorValue: Color {
		.init(rawValue, bundle: .module)
	}
}
