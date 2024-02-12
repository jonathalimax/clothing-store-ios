import SwiftUI

public struct RalewayFont {
	public let name: String

	init(named name: String) {
		self.name = name

		do {
			try AppFonts.register(font: name)
		} catch {
			fatalError("Failed to register font: \(error.localizedDescription)")
		}
	}

	public static let regular = RalewayFont(named: "Raleway-Regular")
	public static let medium = RalewayFont(named: "Raleway-Medium")
	public static let semibold = RalewayFont(named: "Raleway-SemiBold")
	public static let bold = RalewayFont(named: "Raleway-Bold")
}

public extension Font {
	struct Raleway {
		public static func fixed(_ style: RalewayFont, size: AppFonts.Size) -> Font {
			Font.custom(style.name, fixedSize: size.rawValue)
		}
	}
}
