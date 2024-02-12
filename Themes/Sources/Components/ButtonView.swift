import Resources
import SwiftUI

public struct CSButton: View {
	private var title: String
	private var style: Style

	public init(title: String, style: Style = .light) {
		self.title = title
		self.style = style
	}

	public var body: some View {
		Button(action: {}) {
			Text(title)
				.font(.AveriaSerifLibre.fixed(.regular, size: .t2))
				.foregroundStyle(style.foregroundColor)
				.padding()
				.frame(maxWidth: .infinity)
		}
		.background(style.backgroundColor)
		.clipShape(.rect(cornerRadius: 26))
	}
}

extension CSButton {
	public enum Style {
		case dark, light

		var foregroundColor: Color {
			switch self {
			case .dark: return .black
			case .light: return .white
			}
		}

		var backgroundColor: Color {
			switch self {
			case .dark: return .white
			case .light: return .black
			}
		}
	}
}

#Preview("Light") {
	ZStack {
		Color.white.ignoresSafeArea()

		CSButton(title: "Add to Cart")
			.frame(width: 140)
	}
}

#Preview("Dark") {
	ZStack {
		Color.gray.ignoresSafeArea()

		CSButton(title: "Add to Cart", style: .dark)
			.frame(width: 140)
	}
}
