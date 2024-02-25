import Resources
import SwiftUI

public struct CSButtonStyle: ButtonStyle {
	private var style: Style

	public init(_ style: Style) {
		self.style = style
	}

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.frame(maxWidth: .infinity, minHeight: 44)
			.font(.Raleway.fixed(.semibold, size: .t1))
			.background(style.backgroundColor(configuration.isPressed))
			.foregroundColor(style.foregroundColor(configuration.isPressed))
			.cornerRadius(.cornerRadius)
			.overlay(style.borderOverlay(configuration.isPressed))
			.multilineTextAlignment(.center)
	}
}

extension CSButtonStyle {
	public enum Style {
		case dark, light, text

		func foregroundColor(_ isPressed: Bool) -> Color {
			let color: Color = switch self {
			case .dark where isPressed: AppColors.darkBackground.colorValue
			case .dark: AppColors.white.colorValue
			case .light: AppColors.darkBackground.colorValue
			case .text: AppColors.darkBackground.colorValue
			}

			return color.opacity(isPressed ? 0.1 : 1)
		}

		func backgroundColor(_ isPressed: Bool) -> Color {
			let color: Color = switch self {
			case .dark: AppColors.darkBackground.colorValue
			case .light: AppColors.boogerBuster.colorValue
			case .text: .clear
			}

			return color.opacity(isPressed ? 0.1 : 1)
		}

		func borderOverlay(_ isPressed: Bool) -> some View {
			let color = switch self {
			case .dark, .light: Color.clear
			case .text: AppColors.charlestonGreen.colorValue
			}

			return RoundedRectangle(cornerRadius: .cornerRadius)
				.stroke(color.opacity(isPressed ? 0.1 : 1), lineWidth: 2)
		}
	}
}

private extension CGFloat {
	static let cornerRadius: Self = 20
}

#Preview {
	ZStack {
		Color.white.ignoresSafeArea()

		VStack(spacing: 40) {
			Button(action: {}) {
				Text("Add to Cart")
			}
			.buttonStyle(CSButtonStyle(.dark))

			Button(action: {}) {
				Text("Add to Cart")
			}
			.buttonStyle(CSButtonStyle(.light))

			Button(action: {}) {
				Text("Add to Cart")
			}
			.buttonStyle(CSButtonStyle(.text))
		}
		.padding()
	}
}
