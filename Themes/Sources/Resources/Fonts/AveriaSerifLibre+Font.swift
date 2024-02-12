import SwiftUI

public struct AveriaSerifLibreFont {
	public let name: String

	init(named name: String) {
		self.name = name

		do {
			try AppFonts.register(font: name)
		} catch {
			fatalError("Failed to register font: \(error.localizedDescription)")
		}
	}

	public static let regular = AveriaSerifLibreFont(named: "AveriaSerifLibre-Regular")
	public static let bold = AveriaSerifLibreFont(named: "AveriaSerifLibre-Bold")
}

public extension Font {
	struct AveriaSerifLibre {
		public static func fixed(_ style: AveriaSerifLibreFont, size: AppFonts.Size) -> Font {
			Font.custom(style.name, fixedSize: size.rawValue)
		}
	}
}
