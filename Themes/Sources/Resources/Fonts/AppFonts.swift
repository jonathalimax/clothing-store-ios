import CoreGraphics
import CoreText
import SwiftUI

enum AppFontsError: Swift.Error {
	case registerFailure
}

public enum AppFonts {
	static func register(font: String) throws {
		guard
			let fontURL = Bundle.module.url(forResource: font, withExtension: "ttf"),
			CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
		else {
			throw AppFontsError.registerFailure
		}
	}
}

extension AppFonts {
	public enum Size: CGFloat {
		/// 32 px
		case h1 = 32
		/// 28 px
		case h2 = 28
		/// 26 px
		case h3 = 26
		/// 24 px
		case h4 = 24
		/// 22 px
		case h5 = 22
		/// 20 px
		case h6 = 20
		/// 18 px
		case t1 = 18
		/// 16 px
		case t2 = 16
		/// 14 px
		case t3 = 14
	}
}
